defmodule PvtProject.Event.RegisterTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias PvtProject.Event.Guest
  alias PvtProject.Event.Party
  alias PvtProject.Event.RegisterParty

  describe "call/1" do
    test "when params is valid, should registers a new party" do
      party_params = params_with_assocs(:party)

      [
        %{name: guest1_name, paid: false, phone_number: guest1_phone_number},
        %{name: guest2_name, paid: false, phone_number: guest2_phone_number}
      ] = party_params.guests

      assert {:ok, %Party{} = party} = RegisterParty.call(party_params)

      assert party.name == party_params.name
      assert party.description == party_params.description
      assert party.address == party_params.address
      assert party.date == NaiveDateTime.from_iso8601!(party_params.date)

      assert [
               %Guest{name: ^guest1_name, phone_number: ^guest1_phone_number},
               %Guest{name: ^guest2_name, phone_number: ^guest2_phone_number}
             ] = party.guests
    end
  end
end
