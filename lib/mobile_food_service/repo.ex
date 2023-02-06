defmodule MobileFoodService.Repo do
  # Not really a "Repo" in the traditional Ecto sense, but using an API as the repository
  # use Ecto.Repo,
  #   otp_app: :mobile_food_service,
  #   adapter: Ecto.Adapters.Postgres
  alias Finch.{Request, Response}

  require Logger

  @api_config Application.compile_env!(:mobile_food_service, SodaApi)
  @api_endpoint @api_config[:url] <> @api_config[:path]

  def child_spec() do
    {
      Finch,
      name: __MODULE__, pools: %{@api_config[:url] => [size: @api_config[:pool_size]]}
    }
  end

  def all_facilities!() do
    do_request(:get)
  end

  def all_types!() do
    do_request(:get, "?$select=distinct%20facilitytype")
  end

  def get!(id) do
    do_request(:get, "?objectid=#{id}")
  end

  def search!(query) do
    do_request(:get, "?$q=#{query}")
  end

  defp do_request(method, query_params \\ <<>>) do
    start = System.monotonic_time()

    with %Request{method: method, host: host, path: path} = request <-
           Finch.build(method, @api_endpoint <> query_params) do
      response = Finch.request(request, __MODULE__)

      :telemetry.execute(
        [:repo, :call],
        %{duration: System.monotonic_time() - start},
        %{
          method: method,
          host: host,
          path: path
        }
      )

      handle_response!(response)
    end
  end

  defp handle_response!({:ok, %Response{status: status, body: body}}) do
    :telemetry.execute(
      [:repo, :success],
      %{count: 1},
      %{status: status}
    )

    body
    |> Jason.decode!()
  end

  defp handle_response!({:error, e}) do
    Logger.error(Exception.format(:error, e))

    :telemetry.execute(
      [:repo, :error],
      %{count: 1},
      %{error: to_string(e)}
    )

    raise e
  end
end
