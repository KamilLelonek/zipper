defmodule Zipper.DomainTest do
  use Zipper.TestCase, async: true

  alias Zipper.Domain
  alias Zipper.Domain.Agent

  @archive_name "archive"

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

  # def can_download?(archive_name) do
  #   cond do
  #     not Agent.status(archive_name) -> {:error, :not_ready}
  #     File.exists?(archive_name) -> {:ok, archive_name}
  #     true -> {:error, :not_found}
  #   end
  # end
end
