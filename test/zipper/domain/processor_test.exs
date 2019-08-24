defmodule Zipper.Domain.ProcessorTest do
  use Zipper.TestCase, async: true

  alias Zipper.Domain.{Processor, Agent}

  @archive_name "archive"

  setup do
    on_exit(fn -> File.rm(@archive_name) end)

    :ok
  end

  describe "handle_cast/2" do
    test "should prepare archive and mark it as finished" do
      refute Agent.status(@archive_name)
      refute File.exists?(@archive_name)

      Processor.handle_cast({:create_archive, [], @archive_name}, [])

      assert Agent.status(@archive_name)
      assert :ok = File.rm(@archive_name)
    end
  end
end
