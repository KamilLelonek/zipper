defmodule ZipperWeb.Archives.FormTest do
  use Zipper.TestCase, async: true

  alias ZipperWeb.Archives.Form

  describe "new/1" do
    test "should validate incoming params" do
      [%{"url" => url}, %{"filename" => filename}] = params = read_fixture(:files, "valid")

      assert {:ok, [%{url: ^url}, %{filename: ^filename}]} = Form.new(params)
    end

    test "should not validate incoming params when URL is missing" do
      params = read_fixture(:files, "missing_url")

      assert {:error, %{errors: [%{}, %{url: ["can't be blank"]}]}} = Form.new(params)
    end

    test "should not validate incoming params when URL is invalid" do
      params = read_fixture(:files, "invalid_url")

      assert {:error, %{errors: [%{}, %{url: ["has invalid format"]}]}} = Form.new(params)
    end

    test "should not validate incoming params when filename is missing" do
      params = read_fixture(:files, "missing_filename")

      assert {:error, %{errors: [%{filename: ["can't be blank"]}, %{}]}} = Form.new(params)
    end

    test "should not validate incoming params when they are empty" do
      assert {:error, %{errors: ["can't be blank"]}} = Form.new(%{})
      assert {:error, %{errors: ["can't be blank"]}} = Form.new([])
    end

    test "should not validate incoming params when they are missing" do
      assert {:error,
              %{
                errors: [
                  %{filename: ["can't be blank"], url: ["can't be blank"]}
                ]
              }} = Form.new([%{}])
    end
  end
end
