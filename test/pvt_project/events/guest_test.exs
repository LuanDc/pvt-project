defmodule PvtProject.Events.GuestTest do
  use PvtProject.DataCase

  import PvtProject.Factory

  alias PvtProject.Events.Guest

  @invalid_params %{}

  describe "changeset/2" do
    test "when params is valid, returns a valid changeset" do
      guest = string_params_with_assocs(:guest)

      changeset = Guest.changeset(%Guest{}, guest)

      assert changeset.valid?
    end

    test "when params is invalid, returns a invalid changeset" do
      changeset = Guest.changeset(%Guest{}, @invalid_params)

      refute changeset.valid?
    end
  end
end
