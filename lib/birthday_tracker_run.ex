defmodule Mix.Tasks.Tracker do
  @moduledoc "The hello mix task: `mix help hello`"
  use Mix.Task

  @shortdoc "Runs the BirthdayTracker.start/0 function."
  def run(_) do
    Mix.Task.run("app.start")  # Starts your app and supervision tree
    BirthdayTracker.start()
  end
end