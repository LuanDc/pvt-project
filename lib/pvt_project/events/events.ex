defmodule PvtProject.Events do
  @moduledoc """
  The events context.
  """

  alias PvtProject.Repo
  alias PvtProject.Events.Party

  @doc """
  Returns the list of parties

  ## Example

    iex> load_parties()
    [%Party{}, ...]
  """
  @spec load_parties :: [%Party{}, ...]
  def load_parties(), do: Party |> Repo.all()

  @doc """
  Create a new party

  iex> load_parties(valid_params)
  {:ok, %Party{}}

  iex> load_parties(invalid_params)
  {:error, changeset}
  """
  @spec create_party(map()) :: {:ok, %Party{}} | {:error, Ecto.Changeset.t()}
  def create_party(params) do
    changeset = Party.changeset(%Party{}, params)

    case changeset do
      %Ecto.Changeset{valid?: true} ->
        Repo.insert(changeset)

      %Ecto.Changeset{valid?: false} ->
        {:error, changeset}
    end
  end
end
