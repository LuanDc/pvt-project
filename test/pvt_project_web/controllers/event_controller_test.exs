defmodule PvtProjectWeb.EventControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  test "POST /events", %{conn: conn} do
    event = params_for(:event)

    assert conn
           |> post(Routes.events_path(conn, :create), event)
           |> json_response(201)
  end
end
