defmodule ListAgent do
  use Agent

  # Start the agent with an empty list
  def start_link_list(_opts \\ []) do
    case Process.whereis(__MODULE__) do
    nil -> Agent.start_link(fn -> {[], 0} end, name: __MODULE__)
    _pid -> {:ok, __MODULE__}
  end
end
  # Add an item to the list
  def add(item) do
    Agent.update(__MODULE__, fn {list, count} -> {[item | list],count + 1} end)
  end

  # Get the full list
  def get_all do
    Agent.get(__MODULE__, fn {list, _count} -> list end)
  end

  # Remove an item (first match only)
  def remove(item) do
    Agent.update(__MODULE__, fn {list, count} -> {List.delete(list, item), count - 1} end)
  end

  # Clear the list
  def clear do
    Agent.update(__MODULE__, fn _ -> {[],0} end)
  end

  # Count items in the list
  def count do
    Agent.get(__MODULE__, &length/1)
  end

    # Get the count
  def  count_counter do
    Agent.get(__MODULE__, fn {_list, count} -> count end)
  end
end
