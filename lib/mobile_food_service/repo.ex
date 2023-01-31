defmodule MobileFoodService.Repo do
  # Not really a "Repo" in the traditional Ecto sense, but using an API as the repository
  # use Ecto.Repo,
  #   otp_app: :mobile_food_service,
  #   adapter: Ecto.Adapters.Postgres
  alias Finch.Response

  require Logger

  @api_config Application.compile_env!(:mobile_food_service, SodaApi)

  def child_spec do
    {
      Finch,
      name: __MODULE__,
      pools: %{@api_config[:url] => [size: @api_config[:pool_size]]}
    }
  end

  def all_facilities do
    :get
    |> Finch.build(@api_config[:url] <> @api_config[:path])
    |> Finch.request(__MODULE__)
    |> handle_response!()
  end

  def all_types do
    :get
    |> Finch.build(@api_config[:url] <> @api_config[:path] <> "?$select=distinct%20facilitytype")
    |> Finch.request(__MODULE__)
    |> handle_response!()
  end

  def get!(id) do
    :get
    |> Finch.build(@api_config[:url] <> @api_config[:path] <> "?objectid=#{id}")
    |> Finch.request(__MODULE__)
    |> handle_response!()
  end

  def search!(query) do
    :get
    |> Finch.build(@api_config[:url] <> @api_config[:path] <> "?$q=#{query}")
    |> Finch.request(__MODULE__)
    |> handle_response!()
  end

  defp handle_response!({:ok, %Response{body: body}}) do
    body
    |> Jason.decode!()
  end

  defp handle_response!({:error, e}) do
    Logger.error(Exception.format(:error, e))
    raise e
  end
end
