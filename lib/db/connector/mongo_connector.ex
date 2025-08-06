defmodule MongoConnector do
  @moduledoc """
  Handles MongoDB connections using the :mongodb_driver.
  """

  @mongo_url "mongodb://admin:admin@localhost:27017/tracker?authSource=admin"

  def start_connection do
    Mongo.start_link(url: @mongo_url)
  end
end