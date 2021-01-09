defmodule PvtProjectWeb.EventsView do
  use PvtProjectWeb, :view

  alias PvtProject.Event.Party
  alias PvtProjectWeb.GuestView

  def render("index.json", %{events: events}) do
    %{
      data: %{
        events: render_many(events, __MODULE__, "event.json")
      }
    }
  end

  def render("create.json", %{event: event}) do
    %{
      message: "Event Created With Success",
      data: %{
        event: render_one(event, __MODULE__, "event.json", event: event)
      }
    }
  end

  def render("event.json", %{event: %Party{} = event}) do
    %{
      name: event.name,
      address: event.address,
      description: event.description,
      date: event.date,
      guests: render_many(event.guests, GuestView, "guest.json")
    }
  end

  def render("event.json", %{events: %Party{} = event}) do
    %{
      name: event.name,
      address: event.address,
      description: event.description,
      date: event.date
    }
  end
end
