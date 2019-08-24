defmodule Zipper.MixProject do
  use Mix.Project

  def project do
    [
      app: :zipper,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      mod: {Zipper.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.4.9"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, "~> 0.15"},
      {:jason, "~> 1.1"},
      {:plug_cowboy, "~> 2.1"},
      {:httpoison, "~> 1.4"},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.3", only: :test},
      {:bypass, "~> 1.0", only: :test},
      {:zstream, "~> 0.2"}
    ]
  end

  defp aliases do
    [
      test: ["cmd MIX_ENV=test ./scripts/db/reset.sh", "test"]
    ]
  end

  defp releases do
    [
      prod: [
        include_executables_for: [:unix]
      ]
    ]
  end
end
