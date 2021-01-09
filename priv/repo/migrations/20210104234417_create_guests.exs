defmodule PvtProject.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :name, :string
      add :phone_number, :string
      add :paid, :boolean, default: false
      add :party_id, references(:parties, on_delete: :nothing)

      timestamps()
    end

    create index(:guests, [:party_id])
  end
end
