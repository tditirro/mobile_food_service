defmodule MobileFoodService.MobileFoodFacilities do
  @moduledoc """
  The MobileFoodFacilities context.
  """
  alias Ecto.NoResultsError
  alias MobileFoodService.Repo
  alias MobileFoodService.MobileFoodFacilities.{Facility, FacilityType}

  require Logger

  @doc """
  Returns the list of facilities.

  ## Examples

      iex> list_facilities!()
      [%Facility{}, ...]

  """
  def list_facilities!() do
    Repo.all_facilities!()
    |> Enum.reject(&Enum.empty?/1)
    |> Enum.map(fn x -> Facility.changeset(to_facility_map(x)) end)
  end

  @doc """
  Gets a single facility by ID.

  Raises `Ecto.NoResultsError` if the Facility does not exist.

  ## Examples

      iex> get_facility!(123)
      %Facility{}

      iex> get_facility(456)
      ** (Ecto.NoResultsError)

  """
  def get_facility!(id) do
    result = Repo.get!(id)

    if Enum.empty?(result) do
      raise NoResultsError, queryable: "facilities where id = #{id}"
    end

    result
    |> List.first()
    |> to_facility_map()
    |> Facility.changeset()
  end

  @doc """
  Search for facilities by text query and/or location.

  ## Examples

      iex> search(%{"q" => "hamburgers", "latitude" => "37.76785244271805", "longitude" => "-122.41610489253189", "radius" => "5000"})
      [%Facility{}, ...]

  """
  def search!(params) do
    Repo.search!(params)
    |> Enum.map(fn x -> Facility.changeset(to_facility_map(x)) end)
  end

  @doc """
  Returns the list of facility types.

  ## Examples

      iex> list_facility_types!()
      [%FacilityType{}, ...]

  """
  def list_facility_types!() do
    Repo.all_facility_types!()
    |> Enum.reject(&Enum.empty?/1)
    |> Enum.map(fn x -> FacilityType.changeset(%{"name" => x["facilitytype"]}) end)
  end

  def to_facility_map(%{} = params) do
    %{
      "id" => params["objectid"],
      "name" => params["applicant"],
      "type" => params["facilitytype"],
      "food_items" => params["fooditems"],
      "address" => params["address"],
      "latitude" => params["latitude"],
      "longitude" => params["longitude"],
      "location_description" => params["locationdescription"],
      "schedule" => params["dayshours"],
      "schedule_url" => params["schedule"],
      "status" => params["status"]
    }
  end
end
