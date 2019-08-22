import Config

config :zipper, Zipper.Domain.Repo,
  database: "zipper_dev",
  show_sensitive_data_on_connection_error: true

config :zipper, ZipperWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  watchers: []

config :phoenix, :plug_init_mode, :runtime
