defmodule Breathe.MeasurementData do
  def start_link() do
    init = for _n <- 1..8, do: nil
    Agent.start_link(fn -> init end, name: __MODULE__)
  end

  def update(next_interval) do
    Agent.update(__MODULE__, fn state ->
      Enum.slice(state, 1..7) ++ [next_interval]
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn _state -> [] end)
  end

  def current_state() do
    Agent.get(__MODULE__, fn state -> state end)
  end
end
