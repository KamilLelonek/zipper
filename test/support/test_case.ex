defmodule Zipper.TestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest

      alias ZipperWeb.Router.Helpers, as: Routes

      @endpoint ZipperWeb.Endpoint

      import Zipper.TestCase
    end
  end

  setup do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  def read_fixture(entity, name, format \\ :strings) do
    "test/support/fixtures/#{entity}/#{name}.json"
    |> File.read!()
    |> Jason.decode!(keys: format)
  end
end
