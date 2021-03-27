defmodule EctoSummoner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias EctoSummoner.Repo

  @impl true
  def start(_type, _args) do
    children = [
      Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EctoSummoner.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
