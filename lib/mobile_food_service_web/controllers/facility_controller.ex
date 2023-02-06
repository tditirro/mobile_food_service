defmodule MobileFoodServiceWeb.FacilityController do
  use MobileFoodServiceWeb, :controller
  alias MobileFoodService.MobileFoodFacilities

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(MobileFoodFacilities.list_facilities!())
  end

  def show(conn, %{"id" => id} = _params) do
    conn
    |> put_status(:ok)
    |> json(MobileFoodFacilities.get_facility!(id))
  end

  def search(conn, %{"q" => query} = _params) when byte_size(query) > 0 do
    conn
    |> put_status(:ok)
    |> json(MobileFoodFacilities.search_query!(query))
  end

  def search(
        conn,
        %{"latitude" => latitude, "longitude" => longitude, "radius" => radius} = _params
      )
      when byte_size(latitude) > 0 and byte_size(longitude) > 0 do
    conn
    |> put_status(:ok)
    |> json(MobileFoodFacilities.search_location!(latitude, longitude, radius))
  end
end
