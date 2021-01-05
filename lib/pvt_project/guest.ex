defmodule PvtProject.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  alias PvtProject.Event

  schema "guests" do
    field :name, :string
    field :phone_number, :string
    field :paid, :boolean, default: false

    belongs_to :event, Event, foreign_key: :event_id

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:name, :phone_number, :paid])
    |> validate_required([:name, :phone_number])
  end
end
