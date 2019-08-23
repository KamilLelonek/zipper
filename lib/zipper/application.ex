defmodule Zipper.Application do
  use Application

  def start(_type, _args),
    do: Supervisor.start_link(children(), opts())

  defp children do
    [
      Zipper.Domain.Repo,
      Zipper.Domain.Processor,
      ZipperWeb.Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Zipper.Supervisor
    ]
  end

  def config_change(changed, _new, removed) do
    ZipperWeb.Endpoint.config_change(changed, removed)

    :ok
  end
end
