defmodule PvtProjectWeb.PartyControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  @invalid_params %{}

  describe "GET /parties" do
    test "returns 200 status code", %{conn: conn} do
      [party1, party2] = insert_pair(:party)

      expected_response = %{
        "data" => %{
          "parties" => [
            %{
              "name" => party1.name,
              "address" => party1.address,
              "description" => party1.description,
              "date" => NaiveDateTime.to_iso8601(party1.date)
            },
            %{
              "name" => party2.name,
              "address" => party2.address,
              "description" => party2.description,
              "date" => NaiveDateTime.to_iso8601(party2.date)
            }
          ]
        }
      }

      conn = get(conn, Routes.party_path(conn, :index))
      assert json_response(conn, 200) == expected_response
    end
  end

  describe "POST /parties" do
    test "when params is valid, returns 201 status code", %{conn: conn} do
      party = params_for(:party)
      [guest_1, guest_2] = party.guests

      expected_response = %{
        "message" => "Event Created With Success",
        "data" => %{
          "party" => %{
            "name" => party.name,
            "address" => party.address,
            "description" => party.description,
            "date" => party.date,
            "guests" => [
              %{
                "name" => guest_1.name,
                "phoneNumber" => guest_1.phone_number
              },
              %{
                "name" => guest_2.name,
                "phoneNumber" => guest_2.phone_number
              }
            ]
          }
        }
      }

      conn = post(conn, Routes.party_path(conn, :create), party)
      assert json_response(conn, 201) == expected_response
    end

    test "when params is invalid, returns a 400 status code", %{conn: conn} do
      assert conn
             |> post(Routes.party_path(conn, :create), @invalid_params)
             |> json_response(400)
    end
  end
end
