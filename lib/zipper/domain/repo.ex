defmodule Zipper.Domain.Repo do
  use Ecto.Repo,
    otp_app: :zipper,
    adapter: Ecto.Adapters.Postgres

  def init(_, opts),
    do: {:ok, opts(load_from_system_env?(), opts)}

  defp opts(true, opts) do
    Keyword.merge(
      opts,
      system_config()
    )
  end

  defp opts(_, opts), do: opts

  defp system_config do
    [
      url: System.get_env("DATABASE_URL")
    ]
  end

  defp load_from_system_env?,
    do: Application.get_env(:zipper, Zipper.Domain.Repo)[:load_from_system_env]
end
