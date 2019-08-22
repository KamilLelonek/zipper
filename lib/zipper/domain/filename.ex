defmodule Zipper.Domain.Filename do
  @default_length 16
  @default_extension ".zip"

  def generate(extension \\ @default_extension, length \\ @default_length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64(padding: false)
    |> binary_part(0, length)
    |> Kernel.<>(extension)
  end
end
