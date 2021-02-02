defmodule PvtProjectWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use PvtProjectWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import PvtProjectWeb.ConnCase

      alias PvtProjectWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint PvtProjectWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PvtProject.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PvtProject.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

    @doc """
    A helper that transforms changeset errors into a map of messages.

        assert {:error, changeset} = Accounts.create_user(%{password: "short"})
        assert "password is too short" in errors_on(changeset).password
        assert %{password: ["password is too short"]} = errors_on(changeset)

    """
    def errors_on(changeset) do
      Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
        Regex.replace(~r"%{(\w+)}", message, fn _, key ->
          opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
        end)
      end)
    end
end
