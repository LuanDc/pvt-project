defmodule PvtProjectWeb.FallbackController do
  use PvtProjectWeb, :controller

  alias Ecto.Changeset

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PvtProjectWeb.ErrorView)
    |> render("400.json", changeset: changeset)
  end
end
