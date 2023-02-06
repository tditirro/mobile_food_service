defmodule MobileFoodServiceWeb.FacilityTypeController do
  use MobileFoodServiceWeb, :controller
  alias MobileFoodService.MobileFoodFacilities

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(MobileFoodFacilities.list_facility_types!())
  end
end
