defmodule PvtProject.Event do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias PvtProject.Guest

  schema "events" do
    field :address, :string
    field :date, :naive_datetime
    field :description, :string
    field :name, :string

    has_many :guests, Guest

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :address, :date])
    |> cast_assoc(:guests)
    |> validate_required([:name])
  end
end
