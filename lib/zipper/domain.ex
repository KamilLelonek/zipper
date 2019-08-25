defmodule Zipper.Domain do
  alias Zipper.Domain.{Processor, Filename, Agent}

  # NOTE: consider configuring directory

  def create_archive(files) do
    with archive_name <- Filename.generate(files),
         :ok <- Agent.mark_started(archive_name) do
      unless File.exists?(archive_name),
        do: Processor.create_archive(files, archive_name)

      archive_name
    end
  end

  def can_download?(archive_name) do
    cond do
      Agent.status(archive_name) == false -> {:error, :not_ready}
      File.exists?(archive_name) -> {:ok, archive_name}
      true -> {:error, :not_found}
    end
  end
end
