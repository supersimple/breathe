defmodule Breathe.Output do
  use GenServer

  @baseline %{gas_resistance: 71_694, humidity: 41.746, temperature: 21.485, pressure: 801.679}

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    :timer.send_interval(30_000, :draw_frame)
    {:ok, []}
  end

  def handle_info(:draw_frame, _state) do
    Breathe.Display.reset()

    color = Keyword.get(Breathe.colors(), :text)

    Breathe.MeasurementData.current_state()
    |> concat_values()
    |> Breathe.Display.write_graph(color)

    Blinkchain.render()
    {:noreply, []}
  end

  def concat_values(%{
        pressure: pressure,
        temperature: temperature,
        humidity: humidity,
        gas_resistance: gas_resistance
      }) do
    [
      temperature_to_baseline(temperature),
      humidity_to_baseline(humidity),
      pressure_to_baseline(pressure),
      gas_resistance_to_baseline(gas_resistance)
    ]
  end

  defp temperature_to_baseline(nil), do: 0

  defp temperature_to_baseline(value) do
    Map.get(@baseline, :temperature)
    |> Kernel./(value)
    |> temperature_char_from_result()
  end

  defp temperature_char_from_result(result) when result > 1.50, do: -3
  defp temperature_char_from_result(result) when result > 1.30, do: -2
  defp temperature_char_from_result(result) when result > 1.10, do: -1
  defp temperature_char_from_result(result) when result > 0.90, do: 0
  defp temperature_char_from_result(result) when result > 0.80, do: 1
  defp temperature_char_from_result(result) when result > 0.70, do: 2
  defp temperature_char_from_result(result) when result > 0.60, do: 3
  defp temperature_char_from_result(_result), do: 4

  defp humidity_to_baseline(nil), do: 0

  defp humidity_to_baseline(value) do
    Map.get(@baseline, :humidity)
    |> Kernel./(value)
    |> humidity_char_from_result()
  end

  defp humidity_char_from_result(result) when result > 1.75, do: -3
  defp humidity_char_from_result(result) when result > 1.58, do: -2
  defp humidity_char_from_result(result) when result > 1.34, do: -1
  defp humidity_char_from_result(result) when result > 0.77, do: 0
  defp humidity_char_from_result(result) when result > 0.55, do: 1
  defp humidity_char_from_result(result) when result > 0.35, do: 2
  defp humidity_char_from_result(result) when result > 0.15, do: 3
  defp humidity_char_from_result(_result), do: 4

  defp gas_resistance_to_baseline(nil), do: 0

  defp gas_resistance_to_baseline(value) do
    Map.get(@baseline, :gas_resistance)
    |> Kernel./(value)
    |> gas_resistance_char_from_result()
  end

  defp gas_resistance_char_from_result(result) when result > 2.05, do: -3
  defp gas_resistance_char_from_result(result) when result > 1.75, do: -2
  defp gas_resistance_char_from_result(result) when result > 1.45, do: -1
  defp gas_resistance_char_from_result(result) when result > 1.15, do: 0
  defp gas_resistance_char_from_result(result) when result > 0.85, do: 1
  defp gas_resistance_char_from_result(result) when result > 0.55, do: 2
  defp gas_resistance_char_from_result(result) when result > 0.25, do: 3
  defp gas_resistance_char_from_result(_result), do: 4

  defp pressure_to_baseline(nil), do: 0

  defp pressure_to_baseline(value) do
    Map.get(@baseline, :pressure)
    |> Kernel./(value)
    |> pressure_char_from_result()
  end

  defp pressure_char_from_result(result) when result > 1.65, do: -3
  defp pressure_char_from_result(result) when result > 1.40, do: -2
  defp pressure_char_from_result(result) when result > 1.15, do: -1
  defp pressure_char_from_result(result) when result > 0.90, do: 0
  defp pressure_char_from_result(result) when result > 0.65, do: 1
  defp pressure_char_from_result(result) when result > 0.40, do: 2
  defp pressure_char_from_result(result) when result > 0.15, do: 3
  defp pressure_char_from_result(_result), do: 4
end
