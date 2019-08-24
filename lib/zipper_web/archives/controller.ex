defmodule ZipperWeb.Archives.Controller do
  use ZipperWeb.Controller

  alias Zipper.Domain
  alias ZipperWeb.Archives.Form
  alias ZipperWeb.Errors.View

  plug :put_view, View

  # NOTE: assumes transactional insertion
  def upload(conn, params) do
    with %{"_json" => files} <- params,
         {:ok, files} <- Form.new(files) do
      # Domain.create_archive(files)
      send_resp(conn, :accepted, "")
    else
      {:error, errors} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("errors.json", errors: errors)
    end
  end

  def download(conn, %{"name" => archive_name}) do
    case Domain.can_download?(archive_name) do
      {:ok, download_path} ->
        send_download(conn, {:file, download_path})

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> render(:"404")

      {:error, :not_ready} ->
        send_resp(conn, :accepted, "The archive is being prepared.")
    end
  end
end
