defmodule PvtProjectWeb.EventsView do
  use PvtProjectWeb, :view

  alias PvtProject.Event
  alias PvtProjectWeb.{GuestView, EventsView}

  def render("index.json", %{events: events}) do
    %{
      data: %{
        events: Enum.map(events, &render(EventsView, "event.json", event: &1))
      }
    }
  end

  def render("create.json", %{event: event}) do
    %{
      message: "Event Created With Success",
      data: %{
        event: render(EventsView, "event.json", event_guests: event)
      }
    }
  end

  def render("event.json", %{
        event: %Event{
          name: event_name,
          address: event_address,
          description: event_description,
          date: event_date
        }
      }) do
    %{
      name: event_name,
      address: event_address,
      description: event_description,
      date: event_date
    }
  end

  def render("event.json", %{
        event_guests: %Event{
          name: event_name,
          address: event_address,
          description: event_description,
          date: event_date,
          guests: event_guests
        }
      }) do
    %{
      name: event_name,
      address: event_address,
      description: event_description,
      date: event_date,
      guests: render_many(event_guests, GuestView, "guest.json")
    }
  end
end
