import Config

config :ecto_summoner, EctoSummoner.Repo,
  database: "ecto_summoner_repo",
  username: "postgres",
  password: "pass",
  hostname: "localhost"

config :ecto_summoner, :ecto_repos, [EctoSummoner.Repo]
