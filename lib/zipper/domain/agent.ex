defmodule Zipper.Domain.Agent do
  use Agent

  def start_link(_opts),
    do: Agent.start_link(&initial_state/0, name: __MODULE__)

  def state,
    do: Agent.get(__MODULE__, & &1)

  def status(archive_name),
    do: Agent.get(__MODULE__, &Map.get(&1, archive_name))

  def mark_started(archive_name),
    do: Agent.update(__MODULE__, &Map.put(&1, archive_name, false))

  def mark_finished(archive_name),
    do: Agent.update(__MODULE__, &Map.put(&1, archive_name, true))

  def invalidate,
    do: Agent.update(__MODULE__, &initial_state/1)

  defp initial_state(_state \\ nil),
    do: %{}

  # ALTERNATIVE SOLUTION:
  #
  # Handle that with a database
end
