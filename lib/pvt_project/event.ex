defmodule PvtProject.Event do
  alias PvtProject.Event.{RegisterParty, LoadAllParties}

  defdelegate load_parties!(), to: LoadAllParties, as: :call!
  defdelegate register_party(params), to: RegisterParty, as: :call
end
