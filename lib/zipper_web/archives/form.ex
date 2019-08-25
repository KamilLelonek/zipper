defmodule ZipperWeb.Archives.Form do
  use Ecto.Schema

  import Ecto.Changeset

  alias Zipper.Domain.ErrorTranslator

  @regexp_url ~r/^(https?:\/\/)?([\d\p{Ll}\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/u
  @params_required ~w(filename url)a
  @params_optional ~w()a
  @primary_key false

  embedded_schema do
    embeds_many :files, File, primary_key: false do
      field(:url, :string)
      field(:filename, :string)
    end
  end

  def new(files) do
    %{files: files}
    |> changeset()
    |> map_or_error()
  end

  defp changeset(params) do
    __MODULE__.__struct__()
    |> cast(params, [])
    |> cast_embed(:files, with: &file_changeset/2, required: true)
  end

  defp file_changeset(schema, params) do
    schema
    |> cast(params, @params_required ++ @params_optional)
    |> validate()
  end

  defp validate(changeset) do
    changeset
    |> validate_required(@params_required)
    |> validate_format(:url, @regexp_url)
  end

  defp map_or_error(%Ecto.Changeset{valid?: false} = changeset) do
    case ErrorTranslator.call(changeset) do
      %{files: errors} ->
        {:error, %{errors: errors}}
    end
  end

  defp map_or_error(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> apply_changes()
    |> to_map()
  end

  defp to_map(%{files: files}),
    do: {:ok, Enum.map(files, &Map.from_struct/1)}
end
