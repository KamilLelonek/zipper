import Config

config :zipper, ZipperWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  watchers: []

config :phoenix, :plug_init_mode, :runtime
