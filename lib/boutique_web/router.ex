defmodule BoutiqueWeb.Router do
  use BoutiqueWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BoutiqueWeb do
    pipe_through :api

    scope "/auth" do
      post "/register", AccountController, :register
      post "/login", AccountController, :login
    end
  end
end
