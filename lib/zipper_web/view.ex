defmodule ZipperWeb.View do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.View,
        root: "lib/zipper_web/templates",
        namespace: ZipperWeb
    end
  end
end
