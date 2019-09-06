defmodule Breathe.Worker do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    :timer.send_interval(10_000, :draw_frame)
    {:ok, []}
  end

  def handle_info(:draw_frame, _state) do
    # Breathe.Display.reset()
    # # get measurements from data source
    # # need to get last 8 measurements and make a line graph
    # data = [10895, 11899, 10899, 13000, 4000, 10895, 10888, 10989]
    # Breathe.Display.write_graph(data)
    # Blinkchain.render()
    {:noreply, []}
  end
end
