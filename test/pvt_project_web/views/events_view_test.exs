defmodule PvtProjectWeb.EventsViewTest do
  use PvtProjectWeb.ConnCase, async: true

  import Phoenix.View
  import PvtProject.Factory

  test "index.json" do
    [event1, event2] = insert_pair(:event)

    expected_response = %{
      data: %{
        events: [
          %{
            name: event1.name,
            address: event1.address,
            description: event1.description,
            date: event1.date
          },
          %{
            name: event2.name,
            address: event2.address,
            description: event2.description,
            date: event2.date
          }
        ]
      }
    }

    assert expected_response ==
             render(PvtProjectWeb.EventsView, "index.json", events: [event1, event2])
  end

  test "create.json" do
    event = insert(:event)

    [guest_1, guest_2] = event.guests

    expected_response = %{
      message: "Event Created With Success",
      data: %{
        event: %{
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
    }

    assert expected_response == render(PvtProjectWeb.EventsView, "create.json", event: event)
  end
end
