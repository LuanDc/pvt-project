defmodule PvtProjectWeb.ErrorViewTest do
  use PvtProjectWeb.ConnCase, async: true

  import Phoenix.View
  import PvtProject.Factory

  alias PvtProject.Event.Party

  test "renders 400.json when params is a changeset" do
    {_, invalid_params} = params_for(:event) |> Map.pop(:name)
    invalid_changeset = %Party{} |> Party.changeset(invalid_params)

    expected_response = %{
      message: "Bad Request",
      details: %{name: ["can't be blank"]}
    }

    assert expected_response ==
             render(PvtProjectWeb.ErrorView, "400.json", changeset: invalid_changeset)
  end
end
