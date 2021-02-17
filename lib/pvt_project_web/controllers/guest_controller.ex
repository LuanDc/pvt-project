defmodule PvtProjectWeb.GuestController do
  @moduledoc false

  use PvtProjectWeb, :controller

  alias PvtProject.Events

  action_fallback(PvtProjectWeb.FallbackController)

  @doc false
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, guest} <- Events.add_new_guest(params["id"], params["guest"]) do
      conn
      |> put_status(:created)
      |> render("create.json", guest: guest)
    end
  end

  @doc false
  @spec update_payment_status(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update_payment_status(conn, params) do
    with {:ok, guest} <-
           Events.update_guest_payment_status(params["id"], params) do
      conn
      |> put_status(:ok)
      |> render("update_payment_status.json", guest: guest)
    end
  end
end
