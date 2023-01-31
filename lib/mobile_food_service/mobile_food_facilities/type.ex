defmodule MobileFoodService.MobileFoodFacilities.Type do
  @moduledoc """
  Schema, changeset and validations for a mobile food facility type
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  # Overly verbose since they're all the same, but defining separately for demonstration purposes
  @required ~w(name)a
  @permitted @required
  @derivable @permitted
  @derive {Jason.Encoder, only: @derivable}

  @primary_key false
  embedded_schema do
    field :name, :string
  end

  @doc false
  def changeset(type \\ %Type{}, %{} = attrs) do
    type
    |> cast(attrs, @permitted)
    |> validate_required(@required)
    |> apply_action!(:update)
  end
end
