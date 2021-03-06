defmodule PvtProjectWeb.GuestControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  alias PvtProject.Events.Guest

  @invalid_params %{}
  @invalid_party_id 123

  describe "POST /guests" do
    test "when params is valid, renders a create guest message and returns 201 status code", %{
      conn: conn
    } do
      party = insert(:party)
      guest = string_params_for(:guest)

      expected_response = %{
        "message" => "Guest added with success!",
        "guest" => %{
          "name" => guest["name"],
          "phone_number" => guest["phone_number"],
          "paid" => guest["paid"]
        }
      }

      response =
        conn
        |> post(Routes.guest_path(conn, :create, party.id), %{guest: guest})
        |> json_response(:created)

      assert response == expected_response
    end

    test "when params is invalid, returns an error message and 400 status code", %{conn: conn} do
      party = insert(:party)

      errors = string_changeset_errors(@invalid_params)

      expected_response = %{
        "message" => "Bad Request",
        "details" => errors
      }

      response =
        conn
        |> post(Routes.guest_path(conn, :create, party.id), %{guest: @invalid_params})
        |> json_response(:bad_request)

      assert response == expected_response
    end

    test "when party is invalid, returns an error message and 400 status code", %{conn: conn} do
      insert(:party)
      string_params_for(:guest)

      expected_response = %{
        "message" => "Bad Request",
        "details" => "Party not found!"
      }

      response =
        conn
        |> post(Routes.guest_path(conn, :create, @invalid_party_id), %{guest: @invalid_params})
        |> json_response(:bad_request)

      assert expected_response == response
    end
  end

  describe "UPDATE /guests/:id/payment-status" do
    test "when params is valid, change the guest payment status", %{conn: conn} do
      party = insert(:party)
      [guest] = party.guests

      params = %{
        "party_id" => party.id,
        "paid" => true
      }

      expected_response = %{
        "message" => "The guest payment status was updated with success!",
        "guest" => %{
          "name" => guest.name,
          "phone_number" => guest.phone_number,
          "paid" => params["paid"]
        }
      }

      response =
        conn
        |> put(Routes.guest_path(conn, :update_payment_status, guest.id), params)
        |> json_response(:ok)

      assert expected_response == response
    end
  end

  defp string_changeset_errors(params) do
    %Guest{}
    |> Guest.changeset(params)
    |> errors_on()
    |> Enum.reduce(%{}, fn {key, val}, acc ->
      Map.put(acc, Atom.to_string(key), val)
    end)
  end
end
