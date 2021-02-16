defmodule PvtProject.Events do
  @moduledoc """
  The events context.
  """

  import Ecto.Query

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
  def load_parties() do
    from(p in Party, preload: [guests: ^from(g in Guest, order_by: g.name)])
    |> Repo.all()
  end

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
    party =
      Party
      |> Repo.get(party_id)
      |> Repo.preload(:guests)

    case party do
      nil -> {:error, "Party not found!"}
      party -> {:ok, party}
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
  @spec create_party(map()) ::
          {:ok, Events.Party.t()} | {:error, Ecto.Changeset.t()}
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

    iex> add_new_guest(party_id, valid_params)
    {:ok, PvtProject.Events.Party.t()}

    iex> add_new_guest(party_id, invalid_params)
    {:error, changeset}

  """
  @spec add_new_guest(String.t(), map()) ::
          {:ok, Events.Party.t()} | {:error, Ecto.Changeset.t()}
  def add_new_guest(party_id, guest_params) do
    with {:ok, party} <- Events.load_party(party_id) do
      changeset = Guest.changeset(%Guest{}, guest_params)

      case changeset do
        %Ecto.Changeset{valid?: true} = changeset ->
          changeset
          |> Changeset.put_assoc(:party, party)
          |> Repo.insert()

        %Ecto.Changeset{valid?: false} = changeset ->
          {:error, changeset}
      end
    end
  end
end
