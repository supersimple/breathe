defmodule Breathe do
  alias Blinkchain.Color

  @colors [
    text: "#143d6b",
    green: "#1a9458",
    yellow: "#e2cf2d",
    red: "#d22a0b"
  ]

  @doc """
  A keyword list of colors used.
  """
  def colors, do: @colors
end
