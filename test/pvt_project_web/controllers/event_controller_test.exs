defmodule PvtProjectWeb.EventControllerTest do
  use PvtProjectWeb.ConnCase, async: true

  import PvtProject.Factory

  @invalid_params %{}

  describe "GET /events" do
    test "returns 200 status code", %{conn: conn} do
      assert conn
             |> get(Routes.events_path(conn, :index))
             |> json_response(200)
    end
  end

  describe "POST /events" do
    test "when params is valid, returns 201 status code", %{conn: conn} do
      event = params_for(:event)

      assert conn
             |> post(Routes.events_path(conn, :create), event)
             |> json_response(201)
    end

    test "when params is invalid, returns a 400 status code", %{conn: conn} do
      assert conn
             |> post(Routes.events_path(conn, :create), @invalid_params)
             |> json_response(400)
    end
  end
end
