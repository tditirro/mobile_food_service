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

  def search(conn, params) do
    conn
    |> put_status(:ok)
    |> json(MobileFoodFacilities.search!(params))
  end
end
