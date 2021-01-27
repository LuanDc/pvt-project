defmodule PvtProjectWeb.GuestController do
  @moduledoc false

  use PvtProjectWeb, :controller

  alias PvtProject.Events

  action_fallback PvtProjectWeb.FallbackController

  @doc false
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, party} <- Events.add_guest_to_guests_list(params["id"], params["guest"]) do
      conn
      |> put_status(:created)
      |> put_view(PvtProjectWeb.PartyView)
      |> render("party_guests.json", party: party)
    end
  end
end
