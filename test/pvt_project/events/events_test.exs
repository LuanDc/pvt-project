defmodule PvtProject.EventsTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias PvtProject.Repo
  alias PvtProject.Events
  alias PvtProject.Events.{Guest, Party}

  @invalid_id 123

  describe "load_parties/0" do
    test "returns all parties" do
      [party1, party2] = insert_pair(:party)

      parties = Events.load_parties()

      expected_party1 = party1 |> Repo.forget(:guests, :many)
      expected_party2 = party2 |> Repo.forget(:guests, :many)

      assert expected_party1 in parties
      assert expected_party2 in parties
    end
  end

  describe "load_party/1" do
    test "when params is valid, returns a party" do
      party = insert(:party)

      {:ok, %Party{} = loaded_party} = Events.load_party(party.id)
      assert party.id == loaded_party.id
      assert party.name == loaded_party.name
      assert party.description == loaded_party.description
      assert party.address == loaded_party.address
      assert party.date == loaded_party.date
    end

    test "when params is invalid, returna error" do
      {:error, :not_found} = Events.load_party(@invalid_id)
    end
  end

  describe "create_party/1" do
    test "when params is valid, should registers a new party" do
      party_params = params_with_assocs(:party)

      [
        %{name: guest1_name, paid: false, phone_number: guest1_phone_number},
        %{name: guest2_name, paid: false, phone_number: guest2_phone_number}
      ] = party_params.guests

      assert {:ok, %Party{} = party} = Events.create_party(party_params)

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

  describe "add_new_guest/2" do
    test "when params is valid, add a new guest to party's guests list" do
      party = insert(:party)
      guest = params_for(:guest, paid: true)

      assert {:ok, %Guest{} = guest} = Events.add_new_guest(party.id, guest)
      assert guest.name == guest.name
      assert guest.phone_number == guest.phone_number
    end
  end
end
