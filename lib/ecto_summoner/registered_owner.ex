defmodule EctoSummoner.RegisteredOwner do
  use Ecto.Schema

  import Ecto.Changeset

  alias EctoSummoner.GameConsole
  alias EctoSummoner.Manufacturer

  schema "registered_owners" do
    field(:birthday, :date)
    field(:name, :string)

    has_many(:game_consoles, GameConsole)

    many_to_many(:manufacturers, Manufacturer, join_through: :manufacturers_registered_owners)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :birthday])
    |> cast_assoc(:game_consoles)
    |> cast_assoc(:manufacturers)
    |> validate_required([:name, :birthday])
  end
end
