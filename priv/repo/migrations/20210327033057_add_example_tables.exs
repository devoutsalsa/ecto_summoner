defmodule EctoSummoner.Repo.Migrations.AddExampleTables do
  use Ecto.Migration

  def change do
    create table(:manufacturers) do
      add(:name, :string, null: false)

      timestamps()
    end

    create table(:registered_owners) do
      add(:name, :string, null: false)
      add(:birthday, :date, null: false)

      timestamps()
    end

    create table(:game_consoles) do
      add(:name, :string, null: false)
      add(:price_in_cents, :integer, null: false)

      add(:manufacturer_id, references(:manufacturers), null: false)
      add(:registered_owner_id, references(:registered_owners), null: false)

      timestamps()
    end

    create table(:manufacturers_registered_owners) do
      add(:manufacturer_id, references(:manufacturers))
      add(:registered_owner_id, references(:registered_owners), null: false)

      timestamps()
    end

    create table(:peripherals) do
      add(:name, :string, null: false)
      add(:type, :string, null: false)

      add(:game_console_id, references(:game_consoles), null: false)

      timestamps()
    end

    create table(:warranties) do
      add(:title, :string, null: false)
      add(:body, :text, null: false)

      add(:game_console_id, references(:game_consoles), null: false)

      timestamps()
    end

    create table(:logs) do
      add(:log, :text)

      timestamps()
    end
  end
end
