defmodule Breathe.Display do
  @moduledoc """
  Handles outputting data to an LED display.
  Current implementation assumes 8x8 WS2812B matrix
  """
  alias Blinkchain.{Color, Point}

  @doc """
  Reset the display by unlighting all pixels.
  """
  def reset() do
    for x <- 0..7, y <- 0..7 do
      Blinkchain.set_pixel(%Point{x: x, y: y}, light_color(0, nil))
    end
  end

  @doc """
  Show input on the display. Either as chars or a graph.
  """
  def write(input, color) when is_binary(input) do
    input
    |> String.split("", trim: true)
    |> Enum.intersperse(" ")
    |> Enum.map(fn char ->
      Breathe.Font.matrix_for_char(char)
    end)
    |> write(color)
  end

  # Expects a 3 dimensional array of 1 (on) and 0 (off)
  def write(input, color) do
    input
    |> Enum.zip()
    |> Enum.with_index()
    |> Enum.each(fn {row_tuple, y} ->
      row_tuple
      |> Tuple.to_list()
      |> List.flatten()
      |> Enum.with_index()
      |> Enum.each(fn {state, x} ->
        Blinkchain.set_pixel(%Point{x: x, y: y}, light_color(state, color))
      end)
    end)
  end

  def write_graph(data) do
  end

  defp light_color(0, _color), do: Color.parse("#000000")
  defp light_color(1, color), do: Color.parse(color)
end
