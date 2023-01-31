defmodule MobileFoodServiceWeb.Router do
  use MobileFoodServiceWeb, :router

  # alias MobileFoodServiceWeb.TypeController

  pipeline :api do
    plug :accepts, ["json"]
    plug Plug.Telemetry, event_prefix: [:mobile_food_service, :plug]
  end

  scope "/api", MobileFoodServiceWeb do
    scope "/v1" do
      scope "/facilities" do
        pipe_through :api
        get "/types", TypeController, :index
        get "/search", FacilityController, :search
        get "/:id", FacilityController, :show
        get "/", FacilityController, :index
      end
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: MobileFoodServiceWeb.Telemetry
    end
  end
end
