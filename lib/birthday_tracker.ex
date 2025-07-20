defmodule BirthdayTracker do
  @moduledoc """
  Documentation for `BirthdayTracker`.
  """

  @doc """
  add_birthdays

  ## Examples

      iex> BirthdayTracker.add_birthdays()
  """

  def add_birthdays do
    name = IO.gets("Anime Character Name Please: ") |> String.trim()
    if(name == "") do
      IO.puts("Goodbye")
      System.halt(0)
    end
    age = IO.gets("Anime Character Age Please: ") |> String.trim()
    if(age == "") do
      IO.puts("Goodbye")
      :exit
    end
  end
end
