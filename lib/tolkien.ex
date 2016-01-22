defmodule Tolkien do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    stripe_config = %{
      credentials: {"sk_test_BxsY2JiapXjqgvqxFy9EvVUE", ""},
      default_currency: "USD"
    }

    children = [
      # Start the endpoint when the application starts
      supervisor(Tolkien.Endpoint, []),
      # Start the Ecto repository
      worker(Tolkien.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Tolkien.Worker, [arg1, arg2, arg3]),
      worker(Commerce.Billing.Worker, [Commerce.Billing.Gateways.Stripe, stripe_config, [name: :stripe]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tolkien.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Tolkien.Endpoint.config_change(changed, removed)
    :ok
  end
end
