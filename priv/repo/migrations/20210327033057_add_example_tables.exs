defmodule EctoSummoner.Repo.Migrations.AddExampleTables do
  use Ecto.Migration

  def change do
    create table(:manufacturers) do
      add(:name, :string, null: false)

      timestamps()
    end

    create table(:registered_owners) do
      add(:name, :string, null: false)
      add(:birthday, :utc_datetime_usec, null: false)

      timestamps()
    end

    create table(:game_consoles) do
      add(:name, :string, null: false)
      add(:price_in_cents, :integer, null: false)

      add(:manufacturer_id, references(:manufacturers))
      add(:registered_owner_id, references(:registered_owners))

      timestamps()
    end

    create table(:manufacturers_registered_owners) do
      add(:manufacturer_id, references(:manufacturers))
      add(:registered_owner_id, references(:registered_owners))

      timestamps()
    end

    create table(:peripherals) do
      add(:name, :string, null: false)
      add(:type, :string, null: false)

      add(:game_console_id, references(:game_consoles))

      timestamps()
    end

    create table(:warranties) do
      add(:title, :string, null: false)
      add(:body, :text, null: false)

      add(:game_console_id, references(:game_consoles))

      timestamps()
    end
  end
end
