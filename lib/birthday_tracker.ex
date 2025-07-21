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
    IO.gets("Anime Character Name Please: ") |> String.trim() |> check_exit()
  end

  def check_valid_name() do
    name = enter_your_name()

    cond do
      name == :exit ->
        :exit

      name == "" ->
        IO.puts("Name of the character cannot be empty.Use some more chi")
        check_valid_name()

      true ->
        name
    end
  end

  def enter_your_age do
    IO.gets("Anime Character age Please: ") |> String.trim() |> check_exit()
  end

  def check_valid_age() do
    age = enter_your_age()

    cond do
      age == :exit ->
        :exit

      age == "" ->
        IO.puts("Age of the character cannot be empty.Use some more chi")
        check_valid_age()

      detect_type(age) == :text ->
        IO.puts("What age cant have text: kamehameha to you")
        check_valid_age()

      true ->
        age
    end
  end

  def detect_type(str) do
    case Integer.parse(str) do
      {_, ""} -> :number
      _ -> :text
    end
  end

  def enter_your_anime_name do
    IO.gets("Anime Name Please: ") |> String.trim() |> check_exit()
  end

  def check_valid_anime_name() do
    animeName = enter_your_anime_name()

    cond do
      animeName == :exit ->
        :exit

      animeName == "" ->
        IO.puts("Name of the Anime cannot be empty.Use some more chi")
        check_valid_anime_name()

      true ->
        animeName
    end
  end

  def enter_your_anime_gender do
    gender =
      IO.gets("Anime character Gender - Male(M) or Female(F) or other(O): ")
      |> String.downcase()
      |> String.trim()
      |> check_exit()

    cond do
      gender == "m" or gender == "male" -> :male
      gender == "f" or gender == "female" -> :female
      gender == "o" or gender == "other" -> :other
      true -> :invalid
    end
  end

  def check_valid_anime_gender() do
    gender = enter_your_anime_gender()

    cond do
      gender == :exit ->
        :exit

      gender == "" ->
        IO.puts("Gender of the Anime Character cannot be empty.Use some more chi")
        enter_your_anime_gender()

      gender == :invalid ->
        IO.puts("Your character gender is invalid")
        enter_your_anime_gender()

      true ->
        gender
    end
  end

  def add_birthdays do
    case check_valid_name() do
      :exit ->
        IO.puts("Ooooo why")

      name ->
        case check_valid_age() do
          :exit ->
            IO.puts("Ooooo why")

          age ->
            case check_valid_anime_name() do
              :exit ->
                IO.puts("Ooooo why")

              animeName ->
              case check_valid_anime_gender() do
                :exit ->
                IO.puts("Ooooo why")

                gender->

                IO.puts("#{name},#{age}, #{animeName} #{gender}")
                add_birthdays()

              end
            end
        end
    end
  end

  # Handles Ctrl+D and "exit" input
  defp check_exit(nil), do: "exit"
  defp check_exit("exit\n"), do: :exit
  defp check_exit(input), do: input
end
