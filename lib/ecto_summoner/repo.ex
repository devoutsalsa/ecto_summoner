defmodule EctoSummoner.Repo do
  use Ecto.Repo,
    otp_app: :ecto_summoner,
    adapter: Ecto.Adapters.Postgres
end
