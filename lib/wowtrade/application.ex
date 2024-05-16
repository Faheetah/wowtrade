defmodule Wowtrade.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WowtradeWeb.Telemetry,
      Wowtrade.Repo,
      {DNSCluster, query: Application.get_env(:wowtrade, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Wowtrade.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Wowtrade.Finch},
      # Start a worker by calling: Wowtrade.Worker.start_link(arg)
      # {Wowtrade.Worker, arg},
      # Start to serve requests, typically the last entry
      WowtradeWeb.Endpoint,
      # Rate limit module
      Wowtrade.RateLimit
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wowtrade.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WowtradeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
