defmodule PvtProject.Event.LoadAllTest do
  use PvtProject.DataCase, async: true

  import PvtProject.Factory

  alias PvtProject.Repo

  describe "call!" do
    test "returns all events" do
      [event1, event2] = insert_pair(:event)

      events = PvtProject.Event.LoadAll.call!()

      expected_event1 = event1 |> Repo.forget(:guests, :many)
      expected_event2 = event2 |> Repo.forget(:guests, :many)

      assert expected_event1 in events
      assert expected_event2 in events
    end
  end
end
