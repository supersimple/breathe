defmodule Breathe.Init do
  use GenServer
  @wifi_interface Application.get_env(:nerves, :interface)
  @wifi_ssid Application.get_env(:nerves, :ssid)
  @wifi_psk Application.get_env(:nerves, :psk)
  @wifi_key_mgmt Application.get_env(:nerves, :key_mgmt)

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    require Logger
    Logger.info("SETTING UP NETWORK")

    Nerves.Network.setup(
      "#{@wifi_interface}",
      ssid: @wifi_ssid,
      key_mgmt: @wifi_key_mgmt,
      psk: @wifi_psk
    )

    {:ok, []}
  end
end
