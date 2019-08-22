defmodule ZipperWeb.Controller do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller,
        namespace: ZipperWeb
    end
  end
end
