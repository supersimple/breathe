# Breathe
Breathe is an open-source air quality sensing device.

The project is based on the [Adafruit BME680 sensor](https://www.adafruit.com/product/3660).
The sensor has temperature, humidity, barometric pressure, and VOC gas sensing capabilities.
The overall goal of the project is to give a general sense of the air quality in an indoor area over time.

Other components used are the Neopixel 8x8 matrix, a small 3.3v fan (to keep pulling in fresh air), and a Raspberry Pi Zero W. Although any Raspberry Pi could be used.

[wiring diagram](https://github.com/supersimple/breathe/blob/master/breathe_bb.png)

# General Nerves Project information

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
