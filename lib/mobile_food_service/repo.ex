defmodule MobileFoodService.Repo do
  # Not really a "Repo" in the traditional Ecto sense, but using an API as the repository
  # use Ecto.Repo,
  #   otp_app: :mobile_food_service,
  #   adapter: Ecto.Adapters.Postgres
  alias Finch.{Request, Response}

  require Logger

  @api_config Application.compile_env!(:mobile_food_service, SodaApi)
  @api_endpoint @api_config[:url] <> @api_config[:path]
  @default_radius @api_config[:default_radius]

  def child_spec() do
    {
      Finch,
      name: __MODULE__, pools: %{@api_config[:url] => [size: @api_config[:pool_size]]}
    }
  end

  def all_facilities!() do
    do_request!(:get)
  end

  def all_facility_types!() do
    do_request!(:get, "?$select=distinct facilitytype")
  end

  def get!(id) do
    do_request!(:get, "?objectid=#{id}")
  end

  def search!(%{"q" => text, "latitude" => latitude, "longitude" => longitude, "radius" => radius})
      when byte_size(text) > 0 and
             byte_size(latitude) > 0 and
             byte_size(longitude) > 0 and
             byte_size(radius) > 0 do
    (get_location_query(latitude, longitude, radius) <> " and (" <> get_text_query(text) <> ")")
    |> do_search!()
  end

  def search!(%{"q" => text}) when byte_size(text) > 0 do
    get_text_query(text)
    |> do_search!()
  end

  def search!(%{"latitude" => latitude, "longitude" => longitude, "radius" => radius})
      when byte_size(latitude) > 0 and
             byte_size(longitude) > 0 and
             byte_size(radius) > 0 do
    get_location_query(latitude, longitude, radius)
    |> do_search!()
  end

  def search!(%{"latitude" => latitude, "longitude" => longitude})
      when byte_size(latitude) > 0 and byte_size(longitude) > 0 do
    get_location_query(latitude, longitude, @default_radius)
    |> do_search!()
  end

  # No search criteria so just return the full list... could return a 400 Bad Request too
  def search!(%{}) do
    do_request!(:get)
  end

  defp do_request!(method, query_params \\ <<>>) do
    start = System.monotonic_time()

    with %Request{method: method, host: host, path: path} = request <-
           Finch.build(method, @api_endpoint <> URI.encode(query_params)) do
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

  defp do_search!(query) do
    do_request!(:get, "?$where=#{query}")
  end

  defp get_text_query(query) do
    "upper(applicant) like upper('%#{query}%') or upper(fooditems) like upper('%#{query}%') or upper(locationdescription) like upper('%#{query}%') or upper(address) like upper('%#{query}%')"
  end

  defp get_location_query(latitude, longitude, radius) do
    "within_circle(location, #{latitude}, #{longitude}, #{radius})"
  end
end
