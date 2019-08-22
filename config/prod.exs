import Config

config :zipper, ZipperWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: {:system, "HOST"}, port: 80],
  server: true

config :zipper, Zipper.Domain.Repo, load_from_system_env: true
