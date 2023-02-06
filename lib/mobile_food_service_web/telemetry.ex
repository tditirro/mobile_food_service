defmodule MobileFoodServiceWeb.Telemetry do
  @moduledoc false
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # Add reporters as children of your supervision tree.
      # {Telemetry.Metrics.ConsoleReporter, metrics: metrics()},
      # Telemetry poller will execute the given period measurements
      # every 10_000ms. Learn more here: https://hexdocs.pm/telemetry_metrics
      {:telemetry_poller, measurements: periodic_measurements(), period: 10_000}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    app_metrics() ++ phoenix_metrics() ++ repo_metrics() ++ vm_metrics()
  end

  defp app_metrics() do
    [
      # Additional app-specific metrics
    ]
  end

  defp phoenix_metrics() do
    [
      summary("phoenix.endpoint.stop.duration",
        unit: {:native, :millisecond}
      ),
      summary("phoenix.router_dispatch.stop.duration",
        tags: [:method, :status, :route],
        tag_values: &get_router_metadata/1,
        unit: {:native, :millisecond}
      )
    ]
  end

  defp repo_metrics() do
    [
      summary("repo.call.duration",
        tags: [:method, :host, :path],
        unit: {:native, :millisecond}
      ),
      sum("repo.success.count",
        tags: [:status]
      ),
      sum("repo.error.count",
        tags: [:error]
      )
    ]

    # Default Ecto Metrics
    #     summary("mobile_food_service.repo.query.total_time",
    #       unit: {:native, :millisecond},
    #       description: "The sum of the other measurements"
    #     ),
    #     summary("mobile_food_service.repo.query.decode_time",
    #       unit: {:native, :millisecond},
    #       description: "The time spent decoding the data received from the database"
    #     ),
    #     summary("mobile_food_service.repo.query.query_time",
    #       unit: {:native, :millisecond},
    #       description: "The time spent executing the query"
    #     ),
    #     summary("mobile_food_service.repo.query.queue_time",
    #       unit: {:native, :millisecond},
    #       description: "The time spent waiting for a database connection"
    #     ),
    #     summary("mobile_food_service.repo.query.idle_time",
    #       unit: {:native, :millisecond},
    #       description:
    #         "The time the connection spent waiting before being checked out for the query"
    #     )
  end

  defp vm_metrics() do
    [
      last_value("vm.memory.total", unit: {:byte, :kilobyte}),
      last_value("vm.total_run_queue_lengths.total"),
      last_value("vm.total_run_queue_lengths.cpu"),
      last_value("vm.total_run_queue_lengths.io")
    ]
  end

  defp periodic_measurements do
    [
      # A module, function and arguments to be invoked periodically.
      # This function must call :telemetry.execute/3 and a metric must be added above.
      # {MobileFoodServiceWeb, :count_users, []}
    ]
  end

  defp get_router_metadata(%{conn: %{method: method, status: status}} = metadata) do
    Map.merge(metadata, %{method: method, status: status})
  end
end
