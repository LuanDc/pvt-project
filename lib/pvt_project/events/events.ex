defmodule PvtProject.Events do
  @moduledoc """
  The events context.
  """

  alias Ecto.Changeset
  alias PvtProject.Repo
  alias PvtProject.Events
  alias PvtProject.Events.{Guest, Party}

  @doc """
  Returns the list of parties

  ## Example

    iex> load_parties()
    [PvtProject.Events.Party.t(), ...]

  """
  @spec load_parties :: [Events.Party.t(), ...]
  def load_parties(), do: Party |> Repo.all()

  @doc """
  Returns a party

  ## Example

    iex> load_party(party_id)
    {:ok, PvtProject.Events.Party.t()}

    iex> load_party(invalid_party_id)
    {:error, changeset}

  """
  @spec load_party(any) :: {:ok, Events.Party.t()}
  def load_party(party_id) do
    case Repo.get(Party, party_id) do
      nil -> {:error, :not_found}
      party -> {:ok, party}
    end
  end

  @doc """
  Returns a party and load all associations

  ## Example
    iex> load_party(party_id)
    {:ok, PvtProject.Events.Party.t()}

    iex> load_party(invalid_party_id)
    {:error, changeset}

  """
  @spec load_party_and_assocs(String.t()) ::
          {:ok, Events.Party.t()} | {:error, Ecto.Changeset.t()}
  def load_party_and_assocs(party_id) do
    with {:ok, party} <- Events.load_party(party_id) do
      {:ok, Events.load_guests_from_party(party)}
    end
  end

  @doc """
  Create a new party

  ## Example

    iex> load_parties(valid_params)
    {:ok, PvtProject.Events.Party.t()}

    iex> load_parties(invalid_params)
    {:error, changeset}

  """
  @spec create_party(map()) :: {:ok, Events.Party.t()} | {:error, Ecto.Changeset.t()}
  def create_party(params) do
    changeset = Party.changeset(%Party{}, params)

    case changeset do
      %Ecto.Changeset{valid?: true} ->
        Repo.insert(changeset)

      %Ecto.Changeset{valid?: false} ->
        {:error, changeset}
    end
  end

  @doc """
  Add a guest to party's guest list

  ## Example

    iex> add_guest_to_guests_list(party_id, valid_params)
    {:ok, PvtProject.Events.Party.t()}

    iex> add_guest_to_guests_list(party_id, invalid_params)
    {:error, changeset}

  """
  @spec add_guest_to_guests_list(String.t(), map()) ::
          {:ok, Events.Party.t()} | Ecto.Changeset.t()
  def add_guest_to_guests_list(party_id, guest_params) do
    with {:ok, party} <- Events.load_party(party_id),
         %Ecto.Changeset{valid?: true} = changeset <- Guest.changeset(%Guest{}, guest_params) do
      changeset
      |> Changeset.put_assoc(:party, party)
      |> Repo.insert()
      |> handle_guest_insert(party)
    end
  end

  defp handle_guest_insert({:ok, %Guest{} = _guest}, %Party{} = party),
    do: Events.load_party_and_assocs(party.id)

  @doc """
  Receives a party and load guests assoc

  ## Example

    iex> load_guests_from_party(party)
    PvtProject.Events.Party.t()

  """
  @spec load_guests_from_party(Events.Party.t()) :: Events.Party.t()
  def load_guests_from_party(%Party{} = party) do
    Repo.preload(party, :guests)
  end
end
