defmodule PvtProjectWeb.GuestViewTest do
  use PvtProjectWeb.ConnCase, async: true

  import Phoenix.View
  import PvtProject.Factory

  test "create.json" do
    guest = insert(:guest)

    expected_response = %{
      name: guest.name,
      phone_number: guest.phone_number
    }

    assert expected_response == render(PvtProjectWeb.GuestView, "guest.json", guest: guest)
  end
end
