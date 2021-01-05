defmodule PvtProject.Event.RegisterTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias PvtProject.Guest
  alias PvtProject.Event.Register

  describe "call/1" do
    test "when params is valid, should registers a new event" do
      event_params = params_with_assocs(:event)

      [
        %{name: guest1_name, paid: false, phone_number: guest1_phone_number},
        %{name: guest2_name, paid: false, phone_number: guest2_phone_number}
      ] = event_params.guests

      assert {:ok, event} = Register.call(event_params)

      assert event.name == event_params.name
      assert event.description == event_params.description
      assert event.address == event_params.address
      assert event.date == NaiveDateTime.from_iso8601!(event_params.date)

      assert [
               %Guest{name: ^guest1_name, phone_number: ^guest1_phone_number},
               %Guest{name: ^guest2_name, phone_number: ^guest2_phone_number}
             ] = event.guests
    end
  end
end
