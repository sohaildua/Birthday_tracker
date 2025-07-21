defmodule BirthdayTracker do

  def start do
    IO.puts("Welcome! (Type 'exit' to quit at any time)")
    add_birthdays()
  end

  @moduledoc """
  Documentation for `BirthdayTracker`.
  """

  @doc """
  add_birthdays

  ## Examples

      iex> BirthdayTracker.start()
  """
  def enter_your_name do
    IO.gets("Anime Character Name Please: ") |> String.trim()
  end

  def check_valid_name() do
    name = enter_your_name()
    cond do
      name == :exit -> :exit
      name == "" ->
        IO.puts("Name of the character cannot be empty.Use some more chi")
        check_valid_name()
      true -> name
    end
  end
  def enter_your_age do
    IO.gets("Anime Character agee Please: ") |> String.trim()
  end

  def check_valid_age() do
    age = enter_your_name()
    cond do
      age == :exit -> :exit
      age == "" ->
        IO.puts("Age of the character cannot be empty.Use some more chi")
        check_valid_age()
      detect_type(age) == :text ->
        IO.puts("What age cant have text: kamehameha to you")
        check_valid_age()
      true -> age
    end
  end

  def detect_type(str) do
    case Integer.parse(str) do
      {_, ""} -> :number
      _ -> :text
    end
  end

  def add_birthdays do
    check_valid_name()
    check_valid_age()
  end
end
