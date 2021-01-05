defmodule PvtProjectWeb.EventsViewTest do
  use PvtProjectWeb.ConnCase, async: true

  import Phoenix.View
  import PvtProject.Factory

  test "create.json" do
    event = insert(:event)

    [guest_1, guest_2] = event.guests

    expected_response = %{
      message: "Event Created With Success",
      data: %{
        name: event.name,
        address: event.address,
        description: event.description,
        date: event.date,
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

    assert expected_response == render(PvtProjectWeb.EventsView, "create.json", event: event)
  end
end
