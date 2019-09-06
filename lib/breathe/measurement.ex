defmodule Breathe.Measurement do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    resp = Bme680.start_link(i2c_address: 0x77)
    :timer.send_interval(10_000, :collect_data)
    resp
  end

  def handle_info(:collect_data, state) do
    require Logger
    Logger.info("current state is #{inspect(state)}")
    measurement = Bme680.measure(state)
    Logger.info("measurement is #{inspect(measurement)}")
    # set measurements in document store
    snapshot = %Breathe.Snapshot{
      id: DateTime.to_unix(DateTime.utc_now(), :microsecond),
      gas_resistance: measurement.gas_resistance,
      humidity: measurement.humidity,
      pressure: measurement.pressure,
      temperature: measurement.temperature
    }

    Diplomat.Entity.new(snapshot, "test-data") |> Diplomat.Entity.insert()

    {:noreply, state}
  end
end
