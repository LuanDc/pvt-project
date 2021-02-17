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

  @doc """
    Returns a guest

    ## Example

      iex> load_guest(invalid_guest_id)
      {:ok, PvtProject.Events.Party.t()}

      iex> load_guest(invalid_guest_id)
      {:error, String.t()}

  """
  @spec load_guest(String.t()) ::
          {:ok, Events.Guest.t()} | {:error, Ecto.Changeset.t()}
  def load_guest(guest_id) do
    response = Repo.get(Guest, guest_id)

    case response do
      nil -> {:error, "Guest not found!"}
      guest -> {:ok, guest}
    end
  end

  @doc """
    Returns a guest

    ## Example

      iex> update_guest_payment_status(guest_id, params)
      {:ok, PvtProject.Events.Party.t()}

      iex> load_guest(invalid_guest_id)
      {:error, String.t()}

  """
  @spec update_guest_payment_status(String.t(), map()) ::
          {:ok, Events.Guest.t()} | {:error, Ecto.Changeset.t()}
  def update_guest_payment_status(guest_id, params) do
    with {:ok, _party} <- Events.load_party(params["party_id"]),
         {:ok, guest} <- Events.load_guest(guest_id) do
      changeset_params = %{paid: params["paid"]}
      changeset = Guest.changeset(guest, changeset_params)

      case changeset do
        %Ecto.Changeset{valid?: true} ->
          Repo.update(changeset)

        %Ecto.Changeset{valid?: false} = changeset ->
          {:error, changeset}
      end
    end
  end
end
