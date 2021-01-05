defmodule PvtProject.Event.Register do
  @moduledoc false

  alias PvtProject.{Repo, Event}

  @doc false
  @spec call(map()) :: {:ok, %Event{}}
  def call(params) do
    %Event{}
    |> Event.changeset(params)
    |> handle_changeset()
  end

  defp handle_changeset(%Ecto.Changeset{valid?: true} = changeset),
    do: Repo.insert(changeset)
end
