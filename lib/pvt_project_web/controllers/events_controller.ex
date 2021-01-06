defmodule PvtProjectWeb.EventsController do
  @moduledoc false

  use PvtProjectWeb, :controller

  action_fallback PvtProjectWeb.FallbackController

  @doc false
  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    events = PvtProject.load_events!()

    conn
    |> put_status(:ok)
    |> render("index.json", events: events)
  end

  @doc false
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, event} <- PvtProject.register_event(params) do
      conn
      |> put_status(:created)
      |> render("create.json", event: event)
    end
  end
end
