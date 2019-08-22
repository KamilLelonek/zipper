defmodule ZipperWeb.Archives.Controller do
  use ZipperWeb.Controller

  def upload(conn, _params) do
    send_resp(conn, :ok, "")
  end

  def download(conn, _params) do
    send_resp(conn, :ok, "")
  end
end
