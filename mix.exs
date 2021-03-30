defmodule EctoSummoner.MixProject do
  use Mix.Project

  #######
  # API #
  #######

  def application() do
    [
      extra_applications: [:logger],
      mod: {EctoSummoner.Application, []}
    ]
  end

  def project() do
    [
      aliases: aliases(),
      app: :ecto_summoner,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  ###########
  # Private #
  ###########

  defp aliases() do
    [
      "ecto.reset": ["ecto.drop", "ecto.create", "ecto.migrate"]
    ]
  end

  defp deps() do
    [
      # SQL database wrapper
      {:ecto_sql, "~> 3.0"},
      # Incremental fake data
      {:plus_one_updoot, "~> 0.4"},
      # PostgreSQL driver
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
