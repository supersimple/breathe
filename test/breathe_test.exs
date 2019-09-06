defmodule BreatheTest do
  use ExUnit.Case
  doctest Breathe

  test "greets the world" do
    assert Breathe.hello() == :world
  end
end
