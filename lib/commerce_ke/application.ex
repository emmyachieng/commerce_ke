defmodule CommerceKe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CommerceKeWeb.Telemetry,
      CommerceKe.Repo,
      {DNSCluster, query: Application.get_env(:commerce_ke, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CommerceKe.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CommerceKe.Finch},
      # Start a worker by calling: CommerceKe.Worker.start_link(arg)
      # {CommerceKe.Worker, arg},
      # Start to serve requests, typically the last entry
      CommerceKeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CommerceKe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CommerceKeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
