defmodule PvtProject.EventTest do
  use PvtProject.DataCase

  import PvtProject.Factory

  alias PvtProject.Event.Party

  @invalid_params %{}

  describe "changeset/2" do
    test "when params is valid, returns a valid changeset" do
      event = params_with_assocs(:event)

      changeset = Party.changeset(%Party{}, event)

      assert changeset.valid?
    end

    test "when params is invalid, returns a invalid changeset" do
      changeset = Party.changeset(%Party{}, @invalid_params)

      refute changeset.valid?
    end
  end
end
