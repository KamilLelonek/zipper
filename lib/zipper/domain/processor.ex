defmodule Zipper.Domain.Processor do
  use GenServer

  alias Zipper.Domain.HttpStream

  def start_link(_),
    do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  @impl true
  def init(state), do: {:ok, state}

  def download(files, archive_name),
    do: GenServer.cast(__MODULE__, {:download, files, archive_name})

  @impl true
  def handle_cast({:download, files, archive_name}, state) do
    files
    |> entries()
    |> Zstream.zip()
    |> into_archive(archive_name)
    |> Stream.run()

    send(self(), :zipped)

    {:noreply, state}
  end

  @impl true
  def handle_info(:zipped, state) do
    {:noreply, state}
  end

  defp entries(files), do: Enum.map(files, &entry/1)

  defp entry(%{"url" => url, "filename" => filename}),
    do: Zstream.entry(filename, HttpStream.get(url))

  defp into_archive(stream, archive_name) do
    archive = File.stream!(archive_name)
    Stream.into(stream, archive)
  end

  # ALTERNATIVE SOLUTION:
  #
  # files
  # |> Enum.map(&Task.async(download_file(&1)))
  # |> Enum.map(&Task.await/1)
  #
  # files =
  #   files
  #   |> Enum.map(&Map.get(&1, "filename"))
  #   |> Enum.map(&String.to_charlist/1)
  #
  # :zip.create("files.zip", files, cwd: ".")
  #
  # defp download_file(%{"url" => url, "filename" => filename}) do
  #   fn ->
  #     url
  #     |> HttpStream.get()
  #     |> Stream.into(File.stream!(filename))
  #     |> Stream.run()
  #   end
  # end
end
