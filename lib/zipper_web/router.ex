defmodule ZipperWeb.Router do
  use Phoenix.Router
  use Plug.ErrorHandler

  alias ZipperWeb.Endpoints.Controller, as: EndpointsController

  pipeline :api do
    plug :accepts, ["json"]
  end

  get("/", EndpointsController, :index, as: :endpoints)

  scope "/", ZipperWeb do
    pipe_through :api
  end
end
