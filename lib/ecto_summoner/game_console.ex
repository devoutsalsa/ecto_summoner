defmodule EctoSummoner.GameConsole do
  use Ecto.Schema

  import Ecto.Changeset

  alias EctoSummoner.Manufacturer
  alias EctoSummoner.Peripheral
  alias EctoSummoner.RegisteredOwner
  alias EctoSummoner.Warranty

  schema "game_consoles" do
    field(:name, :string)
    field(:price_in_cents, :integer)

    belongs_to(:manufacturer, Manufacturer)
    belongs_to(:registered_owner, RegisteredOwner)
    has_many(:peripherals, Peripheral)
    has_one(:warranty, Warranty)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :price_in_cents])
    |> cast_assoc(:manufacturer)
    |> cast_assoc(:registered_owner)
    |> cast_assoc(:peripherals)
    |> cast_assoc(:warranty)
    |> validate_required([:name, :price_in_cents])
  end
end
