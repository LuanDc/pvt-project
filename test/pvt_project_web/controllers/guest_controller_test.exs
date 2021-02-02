defmodule PvtProjectWeb.GuestControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  describe "POST /guests" do
    test "when params is valid, renders a create guest response and returns 201 status code", %{conn: conn} do
      party = insert(:party)
      guest = string_params_for(:guest)

      expected_response = %{
        "message" => "Guest added with success!",
        "guest" => %{
          "name" => guest["name"],
          "phoneNumber" => guest["phone_number"]
        }
      }

      response =
        conn
        |> post(Routes.guest_path(conn, :create, party.id), %{guest: guest})
        |> json_response(conn, 201)

      assert response == expected_response
    end
  end
end
