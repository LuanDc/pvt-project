defmodule PvtProjectWeb.EventsView do
  use PvtProjectWeb, :view

  alias PvtProject.Event
  alias PvtProjectWeb.GuestView

  def render("create.json", %{event: event}) do
    %{
      message: "Event Created With Success",
      data: render_one(event, __MODULE__, "event.json", event: event)
    }
  end

  def render("event.json", %{
        event: %Event{
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
