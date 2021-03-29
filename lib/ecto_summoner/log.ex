defmodule EctoSummoner.Log do
  use Ecto.Schema

  import Ecto.Changeset

  schema "logs" do
    field(:log, :string)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:log])
    |> validate_required([:log])
  end
end
