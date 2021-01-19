defmodule PvtProject.Event.RegisterParty do
  @moduledoc false

  alias PvtProject.Repo
  alias PvtProject.Event.Party

  @doc false
  @spec call(map()) :: {:ok, %Party{}}
  def call(params) do
    %Party{}
    |> Party.changeset(params)
    |> handle_changeset()
  end

  defp handle_changeset(%Ecto.Changeset{valid?: true} = changeset),
    do: Repo.insert(changeset)

  defp handle_changeset(%Ecto.Changeset{valid?: false} = changeset),
    do: {:error, changeset}
end
