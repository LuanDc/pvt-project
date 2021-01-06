defmodule PvtProject do
  alias PvtProject.Event.{Register, LoadAll}

  defdelegate load_events!(), to: LoadAll, as: :call!
  defdelegate register_event(params), to: Register, as: :call
end
