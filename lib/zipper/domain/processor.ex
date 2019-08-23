defmodule Zipper.Domain.Processor do
  use GenServer

  alias Zipper.Domain.{Filename, HttpStream}

  def start_link(_),
    do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  @impl true
  def init(state), do: {:ok, state}
end
