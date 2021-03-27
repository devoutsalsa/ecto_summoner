defmodule EctoSummoner.Warranty do
  use Ecto.Schema

  import Ecto.Changeset

  alias EctoSummoner.GameConsole

  schema "warranties" do
    field(:title, :string)
    field(:body, :string)

    belongs_to(:game_console, GameConsole)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:title, :body])
    |> cast_assoc(:game_console)
    |> validate_required([:title, :body])
  end
end
