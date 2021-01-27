defmodule PvtProjectWeb.GuestView do
  use PvtProjectWeb, :view

  alias PvtProject.Events.Guest

  def render("guest.json", %{
        guest: %Guest{
          name: guest_name,
          phone_number: guest_phone_number
        }
      }) do
    %{
      name: guest_name,
      phone_number: guest_phone_number
    }
  end
end
