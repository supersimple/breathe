defmodule Breathe.Measurement.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      {Breathe.Measurement, []}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
