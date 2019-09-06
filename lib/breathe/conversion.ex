defmodule Breathe.Conversion do
  @moduledoc """
  Module handles conversion from one unit of measure to another unit of measure.
  """

  @doc """
  Expects a pressure input in hPa, and returns the value in inHg.

  ## Examples

      iex> Breathe.Conversion.pressure(803.48, :hpa, :inhg)
      23.7267644

      iex> Breathe.Conversion.pressure(803.48, :hpa, :bar)
      ** (ArgumentError) Conversion from hpa to iex is not supported.
  """
  def pressure(measurement, :hpa, :inhg), do: measurement * 0.02953

  def pressure(measurement, from, to),
    do: raise(ArgumentError, "Conversion from #{from} to #{to} is not supported.")

  @doc """
  Expects a temperature input in Celsius, and returns the value in Farenheit.

  ## Examples

      iex> Breathe.Conversion.temperature(33.33, :c, :f)
      91.994

      iex> Breathe.Conversion.temperature(33.33, :c, :k)
      ** (ArgumentError) Conversion from c to k is not supported.
  """
  def temperature(measurement, :c, :f), do: measurement * 1.8 + 32

  def temperature(_measurement, from, to),
    do: raise(ArgumentError, "Conversion from #{from} to #{to} is not supported.")
end
