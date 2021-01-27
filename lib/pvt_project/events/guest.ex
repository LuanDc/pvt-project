defmodule PvtProject.Events.Guest do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias PvtProject.Events.Party

  schema "guests" do
    field :name, :string
    field :phone_number, :string
    field :paid, :boolean, default: false

    belongs_to :party, Party, foreign_key: :party_id

    timestamps()
  end

  @doc false
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:name, :phone_number, :paid])
    |> validate_required([:name, :phone_number])
  end
end
