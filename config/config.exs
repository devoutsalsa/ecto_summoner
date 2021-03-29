import Config

config :ecto_summoner, EctoSummoner.Repo,
  database: "ecto_summoner_repo",
  username: "postgres",
  password: "pass",
  hostname: "localhost"

config :ecto_summoner, ecto_repos: [EctoSummoner.Repo]

config :ecto_summoner, EctoSummoner.FixtureModuleMapper,
  app: :ecto_summoner,
  default_repo: EctoSummoner.Repo
