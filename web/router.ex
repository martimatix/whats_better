defmodule WhatsBetter.Router do
  use WhatsBetter.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WhatsBetter do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    post "/vote", PageController, :vote
    resources "/things", ThingController
  end

  # Other scopes may use custom stacks.
  # scope "/api", WhatsBetter do
  #   pipe_through :api
  # end
end
