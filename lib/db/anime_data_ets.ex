defmodule BirthdayTrackerData do
  @table :anime_birthday_data

  def start do
    case :ets.info(@table) do
      :undefined ->  :ets.new(@table, [:named_table, :set, :public])
      _ -> :ok
    end
  end

  def add_anime_birthday_data(anime_list_data) do
    Enum.each(anime_list_data, fn %{id: id, name: name, age: age, animeName: animeName, gender: gender} ->
      :ets.insert(@table, {id ,name, age , animeName, gender})
  end)
end

 def get_anime_all_data() do
   IO.inspect(:ets.tab2list(:anime_birthday_data))
   :ets.tab2list(:anime_birthday_data)
end
end