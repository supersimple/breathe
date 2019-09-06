# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :breathe, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
end

keys =
  [
    Path.join([System.user_home!(), ".ssh", "id_rsa.pub"]),
    Path.join([System.user_home!(), ".ssh", "id_ecdsa.pub"]),
    Path.join([System.user_home!(), ".ssh", "id_ed25519.pub"])
  ]
  |> Enum.filter(&File.exists?/1)

if keys == [],
  do:
    Mix.raise("""
    No SSH public keys found in ~/.ssh. An ssh authorized key is needed to
    log into the Nerves device and update firmware on it using ssh.
    See your project's config.exs for this error message.
    """)

config :nerves_firmware_ssh,
  authorized_keys: Enum.map(keys, &File.read!/1)

node_name = if Mix.env() != :prod, do: "breathe"

config :nerves_network,
  regulatory_domain: "US"

config :nerves,
  interface: :wlan0,
  ssid: System.get_env("NERVES_NETWORK_SSID"),
  psk: System.get_env("NERVES_NETWORK_PSK"),
  key_mgmt: System.get_env("NERVES_NETWORK_KEY_MGMT")

config :nerves_init_gadget,
  ifname: "wlan0",
  address_method: :dhcpd,
  mdns_domain: "breathe.local",
  node_name: node_name,
  node_host: :mdns_domain

config :blinkchain,
  canvas: {8, 8}

config :blinkchain, :channel0,
  pin: 18,
  type: :grb,
  brightness: 255,
  arrangement: [
    %{
      type: :matrix,
      origin: {0, 0},
      count: {8, 8},
      progressive: true
    }
  ]

config :goth,
  json: "src/gcp.json" |> File.read!()
