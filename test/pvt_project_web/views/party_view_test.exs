defmodule PvtProjectWeb.PartyViewTest do
  use PvtProjectWeb.ConnCase, async: true

  import Phoenix.View
  import PvtProject.Factory

  test "index.json" do
    [party1, party2] = insert_pair(:party)

    expected_response = %{
      data: %{
        parties: [
          %{
            name: party1.name,
            address: party1.address,
            description: party1.description,
            date: party1.date
          },
          %{
            name: party2.name,
            address: party2.address,
            description: party2.description,
            date: party2.date
          }
        ]
      }
    }

    assert expected_response ==
             render(PvtProjectWeb.PartyView, "index.json", parties: [party1, party2])
  end

  test "create.json" do
    party = insert(:party)

    [guest_1, guest_2] = party.guests

    expected_response = %{
      message: "Event Created With Success",
      data: %{
        party: %{
          name: party.name,
          address: party.address,
          description: party.description,
          date: party.date,
          guests: [
            %{
              name: guest_1.name,
              phone_number: guest_1.phone_number
            },
            %{
              name: guest_2.name,
              phone_number: guest_2.phone_number
            }
          ]
        }
      }
    }

    assert expected_response == render(PvtProjectWeb.PartyView, "create.json", party: party)
  end
end
