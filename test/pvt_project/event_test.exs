defmodule PvtProject.EventTest do
  use PvtProject.DataCase

  import PvtProject.Factory

  alias PvtProject.Event

  @invalid_params %{}

  describe "changeset/2" do
    test "when params is valid, returns a valid changeset" do
      event = params_with_assocs(:event)

      changeset = Event.changeset(%Event{}, event)

      assert changeset.valid?
    end

    test "when params is invalid, returns a invalid changeset" do
      changeset = Event.changeset(%Event{}, @invalid_params)

      refute changeset.valid?
    end
  end
end
