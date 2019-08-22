defmodule ZipperWeb.Errors.ViewTest do
  use Zipper.TestCase, async: true

  import Phoenix.View

  test "renders 404.json" do
    assert render(ZipperWeb.Errors.View, "404.json", []) ==
             %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(ZipperWeb.Errors.View, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
