defmodule MobileFoodServiceWeb.TypeController do
  use MobileFoodServiceWeb, :controller
  alias MobileFoodService.MobileFoodFacilities

  def index(conn, _params) do
    types = MobileFoodFacilities.list_types()
    conn
    |> put_status(:ok)
    |> json(types)
  end

  # def new(conn, _params) do
  #   changeset = MobileFoodFacilities.change_type(%Type{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"type" => type_params}) do
  #   case MobileFoodFacilities.create_type(type_params) do
  #     {:ok, type} ->
  #       conn
  #       |> put_flash(:info, "Type created successfully.")
  #       |> redirect(to: Routes.type_path(conn, :show, type))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   type = MobileFoodFacilities.get_type!(id)
  #   render(conn, "show.html", type: type)
  # end

  # def edit(conn, %{"id" => id}) do
  #   type = MobileFoodFacilities.get_type!(id)
  #   changeset = MobileFoodFacilities.change_type(type)
  #   render(conn, "edit.html", type: type, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "type" => type_params}) do
  #   type = MobileFoodFacilities.get_type!(id)

  #   case MobileFoodFacilities.update_type(type, type_params) do
  #     {:ok, type} ->
  #       conn
  #       |> put_flash(:info, "Type updated successfully.")
  #       |> redirect(to: Routes.type_path(conn, :show, type))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", type: type, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   type = MobileFoodFacilities.get_type!(id)
  #   {:ok, _type} = MobileFoodFacilities.delete_type(type)

  #   conn
  #   |> put_flash(:info, "Type deleted successfully.")
  #   |> redirect(to: Routes.type_path(conn, :index))
  # end
end
