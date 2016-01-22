# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :tolkien, Tolkien.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "B3jwmDlHUBs7+YkPdc370ld3C1lKN22Dh2isrXI4zNyPwpTe1XeFIo/wKIr77ly7",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Tolkien.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Stripe
config = %{credentials: {"sk_test_BQokikJOvBiI2HlWgH4olfQ2", ""},
           default_currency: "USD"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
