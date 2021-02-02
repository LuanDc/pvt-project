defmodule PvtProjectWeb.GuestControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  describe "POST /guests" do
    test "when params is valid, added a new guest and returns 201 status code", %{conn: conn} do
      guest = string_params_for(:guest)
      party = insert(:party)

      conn = post(conn, Routes.guest_path(conn, :create, party.id), %{guest: guest})

      expected_response = %{
        "message" => "Guest added with success!",
        "guest" => %{
          "name" => guest["name"],
          "phoneNumber" => guest["phone_number"]
        }
      }

      assert json_response(conn, 201) == expected_response
    end
  end
end
