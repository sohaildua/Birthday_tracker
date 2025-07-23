defmodule ListAgent do
  use Agent

  # Start the agent with an empty list
  def start_link_list(_opts \\ []) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  # Add an item to the list
  def add(item) do
    Agent.update(__MODULE__, fn list -> [item | list] end)
  end

  # Get the full list
  def get_all do
    Agent.get(__MODULE__, fn list -> list end)
  end

  # Remove an item (first match only)
  def remove(item) do
    Agent.update(__MODULE__, fn list -> List.delete(list, item) end)
  end

  # Clear the list
  def clear do
    Agent.update(__MODULE__, fn _ -> [] end)
  end

  # Count items in the list
  def count do
    Agent.get(__MODULE__, &length/1)
  end
end
