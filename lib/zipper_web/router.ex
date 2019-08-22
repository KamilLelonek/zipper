defmodule ZipperWeb.Router do
  use Phoenix.Router
  use Plug.ErrorHandler

  alias ZipperWeb.Endpoints.Controller, as: EndpointsController

  pipeline :api do
    plug :accepts, ["json"]
  end

  get "/", EndpointsController, :index, as: :endpoints

  scope "/", ZipperWeb do
    pipe_through :api

    scope "/archives", Archives do
      post "/", Controller, :upload, as: :archives
      get "/:name", Controller, :download, as: :archives
    end
  end
end
