defmodule PvtProjectWeb.GuestControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  describe "POST /guests" do
    test "when params is valid, returns 200 status code", %{conn: conn} do
      guest = params_for(:guest)
      party = insert(:party)

      assert conn
             |> post(Routes.guest_path(conn, :create, party.id), %{guest: guest})
             |> json_response(201)
    end
  end
end
