defmodule EctoSummoner.Manufacturer do
  use Ecto.Schema

  import Ecto.Changeset

  alias EctoSummoner.GameConsole
  alias EctoSummoner.RegisteredOwner

  schema "manufacturers" do
    field(:name, :string)

    has_many(:game_consoles, GameConsole)

    many_to_many(:registered_owners, RegisteredOwner,
      join_through: :manufacturers_registered_owners
    )

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> cast_assoc(:game_consoles)
    |> cast_assoc(:registered_owners)
    |> validate_required([:name])
  end
end
