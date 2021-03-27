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

  defp deps() do
    [
      # SQL database wrapper
      {:ecto_sql, "~> 3.0"},
      # PostgreSQL driver
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
