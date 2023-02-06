defmodule MobileFoodService.MobileFoodFacilities.Facility do
  @moduledoc """
  Schema, changeset and validations for a mobile food facility
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  # Overly verbose since they're all the same, but defining separately for demonstration purposes
  @required ~w(id name address latitude longitude schedule_url status)a
  @permitted ~w(id name type food_items address latitude longitude location_description schedule schedule_url status)a
  @derivable @permitted
  @derive {Jason.Encoder, only: @derivable}

  @primary_key {:id, :id, autogenerate: false}
  embedded_schema do
    field :address, :string
    field :food_items, :string
    field :latitude, :string
    field :longitude, :string
    field :location_description, :string
    field :name, :string
    field :schedule, :string
    field :schedule_url, :string
    field :status, :string
    field :type, :string
  end

  @doc false
  def changeset(facility \\ %Facility{}, %{} = attrs) do
    facility
    |> cast(attrs, @permitted)
    |> validate_required(@required)
    |> apply_action!(:update)
  end
end
