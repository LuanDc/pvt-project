defmodule PvtProject.EventsTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias PvtProject.Repo
  alias PvtProject.Events
  alias PvtProject.Events.{Guest, Party, Parties}

  describe "load_parties/0" do
    test "returns all parties" do
      [event1, event2] = insert_pair(:party)

      parties = Parties.load_parties()

      expected_event1 = event1 |> Repo.forget(:guests, :many)
      expected_event2 = event2 |> Repo.forget(:guests, :many)

      assert expected_event1 in parties
      assert expected_event2 in parties
    end
  end

  describe "create_party/1" do
    test "when params is valid, should registers a new party" do
      party_params = params_with_assocs(:party)

      [
        %{name: guest1_name, paid: false, phone_number: guest1_phone_number},
        %{name: guest2_name, paid: false, phone_number: guest2_phone_number}
      ] = party_params.guests

      assert {:ok, %Party{} = party} = Parties.create_party(party_params)

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
