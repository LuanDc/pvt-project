defmodule PvtProjectWeb.PartyController do
  @moduledoc false

  use PvtProjectWeb, :controller

  alias PvtProject.Events

  action_fallback PvtProjectWeb.FallbackController

  @doc false
  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    parties = Events.load_parties()

    conn
    |> put_status(:ok)
    |> render("index.json", parties: parties)
  end

  @doc false
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, party} <- Events.create_party(params) do
      conn
      |> put_status(:created)
      |> render("create.json", party: party)
    end
  end
end
