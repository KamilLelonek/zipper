defmodule Zipper.Domain.FilenameTest do
  use Zipper.TestCase, async: true

  alias Zipper.Domain.Filename

  describe "generate/2" do
    test "should generate a random filename" do
      assert is_binary(Filename.generate())
    end

    test "should generate a random filename with the given length" do
      size = 8
      extension = ".pdf"

      assert <<x::binary-size(size)>> <> ^extension = Filename.generate(extension, size)
    end

    test "should generate a random filename with the given extension" do
      extension = ".wtf"

      assert Filename.generate(extension) =~ extension
    end
  end
end
