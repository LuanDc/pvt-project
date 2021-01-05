defmodule PvtProjectWeb.EventControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  describe "POST /events" do
    test "when params is valid, returns 200 status code", %{conn: conn} do
      event = params_for(:event)

      assert conn
             |> post(Routes.events_path(conn, :create), event)
             |> json_response(201)
    end
  end
end
