defmodule ZipperWeb.Archives.Controller do
  use ZipperWeb.Controller

  alias ZipperWeb.Archives.Form
  alias ZipperWeb.Errors.View

  # NOTE: assumes transactional insertion
  def upload(conn, params) do
    with %{"_json" => files} <- params,
         {:ok, files} <- Form.new(files) do
      send_resp(conn, :ok, "")
    else
      {:error, errors} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(View)
        |> render("errors.json", errors: errors)
    end
  end

  def download(conn, _params) do
    send_resp(conn, :ok, "")
  end
end
