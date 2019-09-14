defmodule Breathe.MeasurementData do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  def update(next_interval) do
    Agent.update(__MODULE__, fn state ->
      next_interval
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn _state -> nil end)
  end

  def current_state() do
    Agent.get(__MODULE__, fn state -> state end)
  end
end
