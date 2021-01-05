defmodule PvtProjectWeb.EventsController do
  use PvtProjectWeb, :controller

  def create(conn, params) do
    with {:ok, event} <- PvtProject.register_event(params) do
      conn
      |> put_status(:created)
      |> render("create.json", event: event)
    end
  end
end
