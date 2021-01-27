defmodule PvtProject.EventTest do
  use PvtProject.DataCase

  import PvtProject.Factory

  alias PvtProject.Events.Party

  @invalid_params %{}

  describe "changeset/2" do
    test "when params is valid, returns a valid changeset" do
      party = params_with_assocs(:party)

      changeset = Party.changeset(%Party{}, party)

      assert changeset.valid?
    end

    test "when params is invalid, returns a invalid changeset" do
      changeset = Party.changeset(%Party{}, @invalid_params)

      refute changeset.valid?
    end
  end
end
