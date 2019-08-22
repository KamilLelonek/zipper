defmodule ZipperWeb.Archives.ControllerTest do
  use Zipper.TestCase, async: true

  describe "upload" do
    test "should upload a valid JSON", %{conn: conn} do
      files = read_fixture(:files, "valid")

      assert conn
             |> post(Routes.archives_path(conn, :upload), _json: files)
             |> response(:ok)
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
  end
end
