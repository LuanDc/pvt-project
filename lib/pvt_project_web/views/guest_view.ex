defmodule PvtProjectWeb.GuestView do
  use PvtProjectWeb, :view

  alias PvtProjectWeb.GuestView
  alias PvtProject.Events.Guest

  def render("create.json", %{guest: %Guest{} = guest}) do
    %{
      message: "Guest added with success!",
      guest: render_one(guest, GuestView, "guest.json", guest: guest)
    }
  end

  def render("update_payment_status.json", %{guest: %Guest{} = guest}) do
    %{
      message: "The guest payment status was updated with success!",
      guest: render_one(guest, GuestView, "guest.json", guest: guest)
    }
  end

  def render("guest.json", %{guest: %Guest{} = guest}) do
    %{
      name: guest.name,
      phone_number: guest.phone_number,
      paid: guest.paid
    }
  end
end
