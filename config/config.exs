# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# config :mobile_food_service,
#   ecto_repos: [MobileFoodService.Repo]

# Configures the endpoint
config :mobile_food_service, MobileFoodServiceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MobileFoodServiceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MobileFoodService.PubSub,
  live_view: [signing_salt: "7y+pFmZq"]

config :mobile_food_service, :generators, migration: false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mobile_food_service, SodaApi,
  url: "https://data.sfgov.org",
  path: "/resource/rqzj-sfat.json",
  pool_size: 5

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
