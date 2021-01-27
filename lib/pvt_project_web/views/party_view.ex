defmodule PvtProjectWeb.PartyView do
  use PvtProjectWeb, :view

  alias PvtProject.Events.Party
  alias PvtProjectWeb.GuestView

  def render("index.json", %{parties: parties}) do
    %{
      data: %{
        parties: render_many(parties, __MODULE__, "party.json")
      }
    }
  end

  def render("show.json", %{party: party}) do
    %{
      data: %{
        party: render_one(party, __MODULE__, "party_guests.json", party: party)
      }
    }
  end

  def render("create.json", %{party: party}) do
    %{
      message: "Event Created With Success",
      data: %{
        party: render_one(party, __MODULE__, "party_guests.json", party: party)
      }
    }
  end

  def render("party_guests.json", %{party: %Party{} = party}) do
    %{
      name: party.name,
      address: party.address,
      description: party.description,
      date: party.date,
      guests: render_many(party.guests, GuestView, "guest.json")
    }
  end

  def render("party.json", %{party: %Party{} = party}) do
    %{
      name: party.name,
      address: party.address,
      description: party.description,
      date: party.date
    }
  end
end
