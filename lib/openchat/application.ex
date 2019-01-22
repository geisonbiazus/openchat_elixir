defmodule OpenChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    # List all child processes to be supervised

    children = [
      # Starts a worker by calling: OpenChat.Worker.start_link(arg)
      # {OpenChat.Worker, arg},
      {Plug.Cowboy, scheme: :http, plug: OpenChat.Router, options: [port: port()]},
      {OpenChat.Repositories.UserRepo, name: UserRepo}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OpenChat.Supervisor]

    Logger.info("Starting application")
    Supervisor.start_link(children, opts)
  end

  defp port do
    Application.get_env(:openchat, :port)
  end
end
