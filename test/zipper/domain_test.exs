defmodule Zipper.DomainTest do
  use Zipper.TestCase, async: true

  alias Zipper.Domain
  alias Zipper.Domain.{Agent, Processor}

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
      pid = GenServer.whereis(Processor)
      :erlang.trace(pid, true, [:receive])

      archive_name = Domain.create_archive([])

      assert false == Agent.status(archive_name)

      assert_receive {:trace, ^pid, :receive,
                      {:"$gen_cast", {:create_archive, [], ^archive_name}}}

      assert %{} == :sys.get_state(pid)
      assert :ok = File.rm(archive_name)
    end
  end
end
