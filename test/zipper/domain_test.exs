defmodule Zipper.DomainTest do
  use Zipper.TestCase, async: true

  alias Zipper.Domain
  alias Zipper.Domain.Agent

  @archive_name "archive.zip"

  setup do
    Agent.invalidate()

    on_exit(fn -> File.rm(@archive_name) end)

    :ok
  end

  describe "can_download?/1" do
    test "should report not found" do
      assert {:error, :not_found} = Domain.can_download?(@archive_name)
    end

    test "should report not ready" do
      Agent.mark_started(@archive_name)

      assert {:error, :not_ready} = Domain.can_download?(@archive_name)
    end

    test "should report ready" do
      Agent.mark_finished(@archive_name)

      File.touch(@archive_name)

      assert {:ok, @archive_name} = Domain.can_download?(@archive_name)
    end

    test "should report found" do
      File.touch(@archive_name)

      assert {:ok, @archive_name} = Domain.can_download?(@archive_name)
    end
  end

  describe "create_archive/1" do
    test "should schedule downloading" do
      archive_name =
        :files
        |> read_fixture("valid")
        |> Domain.create_archive()

      assert false == Agent.status(archive_name)

      File.rm(archive_name)
    end
  end
end
