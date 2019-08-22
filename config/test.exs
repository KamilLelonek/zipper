import Config

config :zipper, Zipper.Domain.Repo,
  database: "zipper_test",
  pool: Ecto.Adapters.SQL.Sandbox

config :zipper, ZipperWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
