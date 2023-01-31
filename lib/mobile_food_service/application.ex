defmodule MobileFoodService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # TODO: Initialize data to :ets or a database?
      # Start the "Ecto" (aka API) repository
      MobileFoodService.Repo.child_spec(),

      # Start the Telemetry supervisor
      MobileFoodServiceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MobileFoodService.PubSub},
      # Start the Endpoint (http/https)
      MobileFoodServiceWeb.Endpoint
      # Start a worker by calling: MobileFoodService.Worker.start_link(arg)
      # {MobileFoodService.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MobileFoodService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MobileFoodServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
