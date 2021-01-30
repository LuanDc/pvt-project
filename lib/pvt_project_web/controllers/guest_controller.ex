defmodule PvtProjectWeb.GuestController do
  @moduledoc false

  use PvtProjectWeb, :controller

  alias PvtProject.Events

  action_fallback PvtProjectWeb.FallbackController

  @doc false
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, guest} <- Events.add_new_guest(params["id"], params["guest"]) do
      conn
      |> put_status(:created)
      |> render("create.json", guest: guest)
    end
  end
end
