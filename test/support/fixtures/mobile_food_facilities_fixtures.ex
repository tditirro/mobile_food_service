defmodule MobileFoodService.MobileFoodFacilitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MobileFoodService.MobileFoodFacilities` context.
  """

  @doc """
  Generate a facility.
  """
  def facility_fixture(attrs \\ %{}) do
    {:ok, facility} =
      attrs
      |> Enum.into(%{
        address: "some address",
        food_items: "some food_items",
        id: 42,
        location_description: "some location_description",
        name: "some name",
        schedule: "some schedule",
        schedule_url: "some schedule_url",
        status: "some status",
        type: "some type"
      })
      |> MobileFoodService.MobileFoodFacilities.create_facility()

    facility
  end

  @doc """
  Generate a type.
  """
  def type_fixture(attrs \\ %{}) do
    {:ok, type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MobileFoodService.MobileFoodFacilities.create_type()

    type
  end
end
