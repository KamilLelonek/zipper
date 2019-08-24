defmodule Zipper.Domain.ProcessorTest do
  use Zipper.TestCase, async: false

  alias Zipper.Domain.{Processor, Agent}

  @archive_name "archive.zip"

  setup do
    Agent.invalidate()

    on_exit(fn -> File.rm(@archive_name) end)

    bypass = Bypass.open()

    {:ok, bypass: bypass}
  end

  describe "handle_cast/2" do
    test "should prepare archive and mark it as finished" do
      refute Agent.status(@archive_name)
      refute File.exists?(@archive_name)

      Processor.handle_cast({:create_archive, [], @archive_name}, [])

      assert Agent.status(@archive_name)
      assert :ok = File.rm(@archive_name)
    end

    test "should download file and prepare archive", %{bypass: bypass} do
      file_name = "file.txt"
      file_contents = "contents"

      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, file_contents)
      end)

      Processor.handle_cast(
        {:create_archive,
         [%{"url" => "http://localhost:#{bypass.port}/", "filename" => file_name}],
         @archive_name},
        []
      )

      :zip.unzip('#{@archive_name}')

      assert {:ok, ^file_contents} = File.read(file_name)
      assert :ok = File.rm(file_name)
    end
  end
end
