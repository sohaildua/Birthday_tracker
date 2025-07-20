defmodule BirthdayTrackerTest do
  use ExUnit.Case
  doctest BirthdayTracker

  test "greets the world" do
    assert BirthdayTracker.hello() == :world
  end
end
