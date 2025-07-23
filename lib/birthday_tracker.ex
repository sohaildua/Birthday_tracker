defmodule BirthdayTracker do

  def start do
      ListAgent.start_link_list()

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

  defp enter_your_name do
    IO.gets("Anime Character Name Please: ") |> String.trim() |> check_exit()
  end

  defp check_valid_name() do
    name = enter_your_name()

    cond do
      name == :exit or name == "exit"->
        :exit

      name == "" ->
        IO.puts("Name of the character cannot be empty.Use some more chi")
        check_valid_name()

      true ->
        name
    end
  end

  defp enter_your_age do
    IO.gets("Anime Character age Please: ") |> String.trim() |> check_exit()
  end

  defp check_valid_age() do
    age = enter_your_age()

    cond do
      age == :exit or age =="exit" ->
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

  defp detect_type(str) do
    case Integer.parse(str) do
      {_, ""} -> :number
      _ -> :text
    end
  end

  defp enter_your_anime_name do
    IO.gets("Anime Name Please: ") |> String.trim() |> check_exit()
  end

  defp check_valid_anime_name() do
    animeName = enter_your_anime_name()

    cond do
      animeName == :exit or animeName=="exit"->
        :exit

      animeName == "" ->
        IO.puts("Name of the Anime cannot be empty.Use some more chi")
        check_valid_anime_name()

      true ->
        animeName
    end
  end

  defp enter_your_anime_gender do
    gender =
      IO.gets("Anime character Gender - Male(M) or Female(F) or other(O): ")
      |> String.downcase()
      |> String.trim()
      |> check_exit()

    cond do
      gender == "m" or gender == "male" -> :male
      gender == "f" or gender == "female" -> :female
      gender == "o" or gender == "other" -> :other
      gender == "exit" -> :exit
      true -> :invalid
    end
  end

  defp check_valid_anime_gender() do
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

                  gender ->
                    anime_data = %{name: name, age: age, animeName: animeName, gender: gender}
                    IO.inspect(anime_data)
                    ListAgent.add(anime_data)
                    IO.inspect(ListAgent.get_all())
                    start()
                end
            end
        end
    end
  end

  # Handles Ctrl+D and "exit" input
  defp check_exit(input), do: input

end
