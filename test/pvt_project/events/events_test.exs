defmodule PvtProject.EventsTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias Ecto.Changeset
  alias PvtProject.Events
  alias PvtProject.Events.{Guest, Party}

  @invalid_id 0
  @invalid_params %{}

  describe "load_parties/0" do
    test "returns all parties" do
      [party1, party2] = insert_pair(:party)

      parties = Events.load_parties()

      assert party1 in parties
      assert party2 in parties
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
      assert party.guests == loaded_party.guests
    end

    test "when party id is invalid, returns an error" do
      insert(:party)

      expected_response = {:error, "Party not found!"}
      response = Events.load_party(@invalid_id)

      assert response == expected_response
    end
  end

  describe "create_party/1" do
    test "when params is valid, returns a new party" do
      guest_params = %{name: "guest_name", phone_number: "guest_phone_number"}
      party_params = string_params_with_assocs(:party, guests: [guest_params])

      assert {:ok, %Party{} = party} = Events.create_party(party_params)
      assert party.name == party_params["name"]
      assert party.description == party_params["description"]
      assert party.address == party_params["address"]
      assert party.date

      [guest] = party.guests

      assert guest.name == guest_params.name
      assert guest.phone_number == guest_params.phone_number
    end

    test "when params is invalid, returns a tuple error" do
      party = insert(:party)

      assert {:error, %Changeset{}} = Events.add_new_guest(party.id, @invalid_params)
    end
  end

  describe "add_new_guest/2" do
    test "when params is valid, returns a new guest" do
      party = insert(:party)
      guest_params = string_params_for(:guest, paid: true)

      assert {:ok, %Guest{} = guest} = Events.add_new_guest(party.id, guest_params)
      assert guest.name == guest_params["name"]
      assert guest.phone_number == guest_params["phone_number"]
      assert guest.party_id == party.id
      assert guest.paid
    end

    test "when params is invalid, returns a tuple error" do
      party = insert(:party)
      assert {:error, %Changeset{}} = Events.add_new_guest(party.id, @invalid_params)
    end
  end
end
