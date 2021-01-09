defmodule PvtProject.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:parties) do
      add :name, :string
      add :description, :string
      add :address, :string
      add :date, :naive_datetime

      timestamps()
    end
  end
end
