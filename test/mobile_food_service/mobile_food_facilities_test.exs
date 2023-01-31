defmodule MobileFoodService.MobileFoodFacilitiesTest do
  use MobileFoodService.DataCase

  alias MobileFoodService.MobileFoodFacilities

  describe "facilities" do
    alias MobileFoodService.MobileFoodFacilities.Facility

    import MobileFoodService.MobileFoodFacilitiesFixtures

    @invalid_attrs %{address: nil, food_items: nil, id: nil, location_description: nil, name: nil, schedule: nil, schedule_url: nil, status: nil, type: nil}

    test "list_facilities/0 returns all facilities" do
      facility = facility_fixture()
      assert MobileFoodFacilities.list_facilities() == [facility]
    end

    test "get_facility!/1 returns the facility with given id" do
      facility = facility_fixture()
      assert MobileFoodFacilities.get_facility!(facility.id) == facility
    end

    test "create_facility/1 with valid data creates a facility" do
      valid_attrs = %{address: "some address", food_items: "some food_items", id: 42, location_description: "some location_description", name: "some name", schedule: "some schedule", schedule_url: "some schedule_url", status: "some status", type: "some type"}

      assert {:ok, %Facility{} = facility} = MobileFoodFacilities.create_facility(valid_attrs)
      assert facility.address == "some address"
      assert facility.food_items == "some food_items"
      assert facility.id == 42
      assert facility.location_description == "some location_description"
      assert facility.name == "some name"
      assert facility.schedule == "some schedule"
      assert facility.schedule_url == "some schedule_url"
      assert facility.status == "some status"
      assert facility.type == "some type"
    end

    test "create_facility/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MobileFoodFacilities.create_facility(@invalid_attrs)
    end

    test "update_facility/2 with valid data updates the facility" do
      facility = facility_fixture()
      update_attrs = %{address: "some updated address", food_items: "some updated food_items", id: 43, location_description: "some updated location_description", name: "some updated name", schedule: "some updated schedule", schedule_url: "some updated schedule_url", status: "some updated status", type: "some updated type"}

      assert {:ok, %Facility{} = facility} = MobileFoodFacilities.update_facility(facility, update_attrs)
      assert facility.address == "some updated address"
      assert facility.food_items == "some updated food_items"
      assert facility.id == 43
      assert facility.location_description == "some updated location_description"
      assert facility.name == "some updated name"
      assert facility.schedule == "some updated schedule"
      assert facility.schedule_url == "some updated schedule_url"
      assert facility.status == "some updated status"
      assert facility.type == "some updated type"
    end

    test "update_facility/2 with invalid data returns error changeset" do
      facility = facility_fixture()
      assert {:error, %Ecto.Changeset{}} = MobileFoodFacilities.update_facility(facility, @invalid_attrs)
      assert facility == MobileFoodFacilities.get_facility!(facility.id)
    end

    test "delete_facility/1 deletes the facility" do
      facility = facility_fixture()
      assert {:ok, %Facility{}} = MobileFoodFacilities.delete_facility(facility)
      assert_raise Ecto.NoResultsError, fn -> MobileFoodFacilities.get_facility!(facility.id) end
    end

    test "change_facility/1 returns a facility changeset" do
      facility = facility_fixture()
      assert %Ecto.Changeset{} = MobileFoodFacilities.change_facility(facility)
    end
  end

  describe "types" do
    alias MobileFoodService.MobileFoodFacilities.Type

    import MobileFoodService.MobileFoodFacilitiesFixtures

    @invalid_attrs %{name: nil}

    test "list_types/0 returns all types" do
      type = type_fixture()
      assert MobileFoodFacilities.list_types() == [type]
    end

    test "get_type!/1 returns the type with given id" do
      type = type_fixture()
      assert MobileFoodFacilities.get_type!(type.id) == type
    end

    test "create_type/1 with valid data creates a type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Type{} = type} = MobileFoodFacilities.create_type(valid_attrs)
      assert type.name == "some name"
    end

    test "create_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MobileFoodFacilities.create_type(@invalid_attrs)
    end

    test "update_type/2 with valid data updates the type" do
      type = type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Type{} = type} = MobileFoodFacilities.update_type(type, update_attrs)
      assert type.name == "some updated name"
    end

    test "update_type/2 with invalid data returns error changeset" do
      type = type_fixture()
      assert {:error, %Ecto.Changeset{}} = MobileFoodFacilities.update_type(type, @invalid_attrs)
      assert type == MobileFoodFacilities.get_type!(type.id)
    end

    test "delete_type/1 deletes the type" do
      type = type_fixture()
      assert {:ok, %Type{}} = MobileFoodFacilities.delete_type(type)
      assert_raise Ecto.NoResultsError, fn -> MobileFoodFacilities.get_type!(type.id) end
    end

    test "change_type/1 returns a type changeset" do
      type = type_fixture()
      assert %Ecto.Changeset{} = MobileFoodFacilities.change_type(type)
    end
  end
end
