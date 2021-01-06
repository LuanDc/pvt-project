defmodule PvtProject.Event.LoadAll do
  @moduledoc false

  alias PvtProject.{Repo, Event}

  @doc false
  @spec call! :: [%Event{}, ...]
  def call!() do
    Event
    |> Repo.all()
  end
end
