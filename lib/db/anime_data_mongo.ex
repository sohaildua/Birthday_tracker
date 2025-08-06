defmodule BirthdayTrackerMongoData do
  def insert_all(conn, data) do
    Mongo.insert_many(conn, "anime_characters", data)
  end

  def get_all(conn) do
    Mongo.find(conn, "anime_characters", %{}) |> Enum.to_list()
  end
end