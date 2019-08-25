defmodule Zipper.Domain.Filename do
  @default_extension ".zip"
  @opts [case: :lower, padding: false]

  def generate(params) do
    with {:ok, json} <- Jason.encode(params) do
      :md5
      |> :crypto.hash(json)
      |> Base.url_encode64(@opts)
      |> Kernel.<>(@default_extension)
    end
  end
end
