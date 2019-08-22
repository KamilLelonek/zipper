defmodule ZipperWeb.Endpoints.ControllerTest do
  use Zipper.TestCase, async: true

  alias ZipperWeb.{Endpoint, Router}
  alias Phoenix.Router.Helpers

  test "GET /whatever should return error page", %{conn: conn} do
    assert_raise Phoenix.Router.NoRouteError, fn ->
      get(conn, "/whatever")
    end
  end

  test "GET / should return current endpoints", %{conn: conn} do
    response =
      conn
      |> get(Routes.endpoints_path(conn, :index))
      |> json_response(:ok)

    assert api() == response
  end

  defp api do
    [
      %{
        "endpoints" => "#{url()}/",
        "method" => "get"
      },
      %{
        "archives" => "#{url()}/archives/:name",
        "method" => "get"
      },
      %{
        "archives" => "#{url()}/archives",
        "method" => "post"
      }
    ]
  end

  defp url, do: Helpers.url(Router, Endpoint)
end
