defmodule PvtProject.Repo do
  use Ecto.Repo,
    otp_app: :pvt_project,
    adapter: Ecto.Adapters.Postgres
end
