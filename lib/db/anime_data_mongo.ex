defmodule BirthdayTrackerMongoData do

  def insert_all(conn, name_collection, data) do
    Mongo.insert_many(conn, name_collection, data)
  end

  def get_all(conn, name_collection) do
    Mongo.find(conn, name_collection, %{}) |> Enum.to_list()
  end

  def get_one(conn, name_collection, query) do
    Mongo.find_one(conn,name_collection, query)
    #Mongo.find_one(conn, "web_anime_characters", %{birthdate: month() <> " " <> day()})
  end
end
