defmodule ZipperWeb.Archives.ControllerTest do
  use Zipper.TestCase, async: false

  alias Zipper.Domain.Agent

  @archive_name "archive"

  setup do
    Agent.invalidate()

    on_exit(fn -> File.rm(@archive_name) end)

    :ok
  end

  describe "upload" do
    test "should upload a valid JSON", %{conn: conn} do
      files = read_fixture(:files, "valid")

      assert conn
             |> post(Routes.archives_path(conn, :upload), _json: files)
             |> response(:accepted)
    end

    test "should not upload an invalid JSON", %{conn: conn} do
      files = read_fixture(:files, "missing_url")

      assert %{"errors" => [%{}, %{"url" => ["can't be blank"]}]} =
               conn
               |> post(Routes.archives_path(conn, :upload), _json: files)
               |> json_response(:unprocessable_entity)
    end
  end

  describe "download" do
    test "should download file", %{conn: conn} do
      File.touch(@archive_name)

      assert conn
             |> get(Routes.archives_path(conn, :download, @archive_name))
             |> response(:ok)
    end

    test "should respond with not ready", %{conn: conn} do
      Agent.mark_started(@archive_name)

      assert conn
             |> get(Routes.archives_path(conn, :download, @archive_name))
             |> response(:accepted)
    end

    test "should respond with not found", %{conn: conn} do
      assert conn
             |> get(Routes.archives_path(conn, :download, @archive_name))
             |> response(:not_found)
    end
  end
end
