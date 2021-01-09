defmodule PvtProject.Event.LoadAll do
  @moduledoc false

  alias PvtProject.Repo
  alias PvtProject.Event.Party

  @doc false
  @spec call! :: [%Party{}, ...]
  def call!(), do: Party |> Repo.all()
end
