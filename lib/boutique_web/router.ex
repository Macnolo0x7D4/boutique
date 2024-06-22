defmodule BoutiqueWeb.Router do
  use BoutiqueWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BoutiqueWeb do
    pipe_through :api
  end
end
