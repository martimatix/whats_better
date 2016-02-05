defmodule WhatsBetterPhoenix do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(WhatsBetterPhoenix.Endpoint, []),
      # Here you could define other workers and supervisors as children
      # worker(WhatsBetterPhoenix.Worker, [arg1, arg2, arg3]),
      worker(RethinkDB.Connection, [[name: WhatsBetterPhoenix.Database, host: 'localhost', port: 28015]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WhatsBetterPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WhatsBetterPhoenix.Endpoint.config_change(changed, removed)
    :ok
  end

  defmodule WhatsBetterPhoenix.Database do
    use RethinkDB.Connection
  end
end
