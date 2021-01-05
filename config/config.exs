# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pvt_project,
  ecto_repos: [PvtProject.Repo]

# Configures the endpoint
config :pvt_project, PvtProjectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gOZ5FoM1J7MkETl9Nz5gRRmNv/m/SDll4uMqGCao3RnD3VT78Ye17F85C3BDgiws",
  render_errors: [view: PvtProjectWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PvtProject.PubSub,
  live_view: [signing_salt: "lXAauMiu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
