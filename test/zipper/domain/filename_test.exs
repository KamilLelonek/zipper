defmodule Zipper.Domain.FilenameTest do
  use Zipper.TestCase, async: true

  alias Zipper.Domain.Filename

  @files [%{url: "localhost", filename: "filename"}]

  describe "generate/1" do
    test "should generate a filename based on files" do
      assert is_binary(Filename.generate(@files))
    end

    test "should generate the same filename based on identical files" do
      filename = Filename.generate(@files)

      assert ^filename = Filename.generate(@files)
    end

    test "should generate a filename with the zip extension" do
      assert @files
             |> Filename.generate()
             |> String.ends_with?(".zip")
    end
  end
end
