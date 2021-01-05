defmodule PvtProject.Event.Register do
  alias PvtProject.{Repo, Event}

  def call(params) do
    %Event{}
    |> Event.changeset(params)
    |> handle_changeset()
  end

  def handle_changeset(%Ecto.Changeset{valid?: true} = changeset),
    do: Repo.insert(changeset)

  def handle_changeset(%Ecto.Changeset{valid?: false} = changeset),
    do: changeset
end
