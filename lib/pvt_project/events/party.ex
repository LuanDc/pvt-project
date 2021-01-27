defmodule PvtProject.Events.Party do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias PvtProject.Events.Guest

  schema "parties" do
    field :address, :string
    field :date, :naive_datetime
    field :description, :string
    field :name, :string

    has_many :guests, Guest

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(party, attrs) do
    party
    |> cast(attrs, [:name, :description, :address, :date])
    |> cast_assoc(:guests)
    |> validate_required([:name])
  end
end
