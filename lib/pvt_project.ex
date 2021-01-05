defmodule PvtProject do
  alias PvtProject.Event.Register

  defdelegate register_event(params), to: Register, as: :call
end
