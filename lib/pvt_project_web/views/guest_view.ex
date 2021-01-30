defmodule PvtProjectWeb.GuestView do
  use PvtProjectWeb, :view

  alias PvtProject.Events.Guest

  def render("create.json", %{
        guest: %Guest{
          name: guest_name,
          phone_number: guest_phone_number
        }
      }) do
    %{
      message: "Guest added with success!",
      guest: %{
        name: guest_name,
        phoneNumber: guest_phone_number
      }
    }
  end

  def render("guest.json", %{
        guest: %Guest{
          name: guest_name,
          phone_number: guest_phone_number
        }
      }) do
    %{
      name: guest_name,
      phoneNumber: guest_phone_number
    }
  end
end
