defmodule ZipperWeb.Endpoints.Controller do
  use ZipperWeb.Controller

  alias ZipperWeb.Endpoints.View

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> put_view(View)
    |> render("endpoints.json")
  end
end
