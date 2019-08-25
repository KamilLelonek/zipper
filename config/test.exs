import Config

config :zipper, ZipperWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
