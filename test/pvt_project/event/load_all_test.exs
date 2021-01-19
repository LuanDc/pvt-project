defmodule PvtProject.Event.LoadAllTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias PvtProject.Repo

  describe "call!" do
    test "returns all parties" do
      [event1, event2] = insert_pair(:party)

      parties = PvtProject.Event.LoadAllParties.call!()

      expected_event1 = event1 |> Repo.forget(:guests, :many)
      expected_event2 = event2 |> Repo.forget(:guests, :many)

      assert expected_event1 in parties
      assert expected_event2 in parties
    end
  end
end
