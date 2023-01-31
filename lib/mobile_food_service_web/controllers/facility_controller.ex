defmodule MobileFoodServiceWeb.FacilityController do
  use MobileFoodServiceWeb, :controller
  alias MobileFoodService.MobileFoodFacilities

  def index(conn, _params) do
    facilities = MobileFoodFacilities.list_facilities()

    conn
    |> put_status(:ok)
    |> json(facilities)
  end

  def show(conn, %{"id" => id}) do
    facility = MobileFoodFacilities.get_facility!(id)

    conn
    |> put_status(:ok)
    |> json(facility)
  end

  def search(conn, %{"q" => query} = _params) do
    facilities = MobileFoodFacilities.search!(query)

    conn
    |> put_status(:ok)
    |> json(facilities)
  end
end
