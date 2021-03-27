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
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
