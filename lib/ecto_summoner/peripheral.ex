defmodule EctoSummoner.Peripheral do
  use Ecto.Schema

  import Ecto.Changeset

  alias EctoSummoner.GameConsole

  schema "peripherals" do
    field(:name, :string)
    field(:type, :string)

    belongs_to(:game_console, GameConsole)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :type])
    |> cast_assoc(:game_console)
    |> validate_required([:name, :type])
  end
end
