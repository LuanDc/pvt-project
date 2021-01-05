defmodule PvtProject.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :name, :string
      add :phone_number, :string
      add :paid, :boolean, default: false
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:guests, [:event_id])
  end
end
