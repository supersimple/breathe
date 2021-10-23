defmodule Breathe.Measurement do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    {:ok, resp} = BMP280.start_link(bus_name: "i2c-1", bus_address: 0x77)
    :timer.send_interval(10_000, :collect_data)
    resp
  end

  def handle_info(:collect_data, state) do
    {:ok, measurement} = BMP280.measure(state)

    snapshot = %Breathe.Snapshot{
      id: DateTime.to_unix(DateTime.utc_now(), :microsecond),
      gas_resistance: measurement.gas_resistance_ohms,
      humidity: measurement.humidity_rh,
      pressure: measurement.pressure_pa,
      temperature: measurement.temperature_c
    }

    # store latest snapshot in MeasurementData
    Breathe.MeasurementData.update(snapshot)

    # and send it to the datastore
    Task.start(fn ->
      snapshot
      |> Diplomat.Entity.new(datastore(), snapshot.id)
      |> Diplomat.Entity.insert()
    end)

    {:noreply, state}
  end

  def datastore() do
    Application.get_env(:breathe, :datastore)
  end
end
