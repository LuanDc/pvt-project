defmodule PvtProject.Factory do
  use ExMachina.Ecto, repo: PvtProject.Repo

  def party_factory() do
    %PvtProject.Events.Party{
      name: sequence(:name, &"name #{&1}"),
      description: sequence(:description, &"description #{&1}"),
      address: sequence(:address, &"address #{&1}"),
      date: "2015-01-23 23:50:07",
      guests: build_pair(:guest)
    }
  end

  def guest_factory do
    %PvtProject.Events.Guest{
      name: sequence(:name, &"name #{&1}"),
      phone_number: sequence(:phone_number, &"name #{&1}"),
      paid: false
    }
  end
end
