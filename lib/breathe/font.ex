defmodule Breathe.Font do
  @moduledoc """
  Builds a font using the neopixel matrix.
  """

  @doc """
  Returns a matrix of 1(on) and 0(off) that generates a character.
  """

  @spec matrix_for_char(String.t()) :: {list(), integer(), integer()}
  def matrix_for_char(char), do: char(char)

  defp char("0"),
    do: [[0, 1, 0], [1, 0, 1], [1, 0, 1], [1, 0, 1], [0, 1, 0]]

  defp char("1"), do: [[0, 1], [1, 1], [0, 1], [0, 1], [0, 1]]

  defp char("2"),
    do: [[1, 1, 0], [0, 0, 1], [0, 1, 0], [1, 0, 0], [1, 1, 1]]

  defp char("3"),
    do: [[1, 1, 1], [0, 0, 1], [0, 1, 0], [0, 0, 1], [1, 1, 0]]

  defp char("4"),
    do: [[1, 0, 1], [1, 0, 1], [1, 1, 1], [0, 0, 1], [0, 0, 1]]

  defp char("5"),
    do: [[1, 1, 1], [1, 0, 0], [1, 1, 1], [0, 0, 1], [1, 1, 1]]

  defp char("6"),
    do: [[1, 0, 0], [1, 0, 0], [1, 1, 1], [1, 0, 1], [1, 1, 1]]

  defp char("7"),
    do: [[1, 1, 1], [0, 0, 1], [0, 1, 0], [1, 0, 0], [1, 0, 0]]

  defp char("8"),
    do: [[1, 1, 1], [1, 0, 1], [1, 1, 1], [1, 0, 1], [1, 1, 1]]

  defp char("9"),
    do: [[1, 1, 1], [1, 0, 1], [1, 1, 1], [0, 0, 1], [0, 1, 1]]

  defp char("%"),
    do: [[1, 0, 0], [0, 0, 1], [0, 1, 0], [1, 0, 0], [0, 0, 1]]

  defp char("º"),
    do: [[1], [0], [0], [0], [0]]

  defp char(" "),
    do: [[0], [0], [0], [0], [0]]

  defp char(_not_defined), do: []

  @doc false
  def assemble(chars) do
    p = Enum.zip(chars)
    ll = Enum.map(p, fn row -> Tuple.to_list(row) |> Enum.flat_map(& &1) end)

    Enum.each(ll, fn row ->
      Enum.map(row, fn px ->
        if px == 0, do: List.to_string([9617]), else: List.to_string([9619])
      end)
      |> List.to_string()
      |> IO.puts()
    end)
  end
end
