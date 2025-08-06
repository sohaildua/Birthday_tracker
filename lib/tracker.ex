defmodule Mix.Tasks.Tracker do
  @moduledoc "The hello mix task: mix help hello"
  use Mix.Task

  @shortdoc "Runs the BirthdayTracker.start/0 function."
  def run(_) do
    Mix.Task.run("app.start")  # Starts your app and supervision tree

    # Start Registry required by Mongo driver
  {:ok, _} = Application.ensure_all_started(:db_connection)
  {:ok, _} = Application.ensure_all_started(:mongodb_driver)

  {:ok, _conn} = MongoConnector.start_connection()
    BirthdayTracker.start(_conn)
  end
end