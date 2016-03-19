defmodule WhatsBetter.Router do
  use WhatsBetter.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WhatsBetter.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WhatsBetter do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # TODO: Trim resources
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    post "/vote", PageController, :vote
    resources "/things", ThingController
    resources "/pairs", PairController
    resources "/rankings", RankingController, only: [:index]
    get "/recent_comments", PageController, :recent_comments
  end

  # Other scopes may use custom stacks.
  # scope "/api", WhatsBetter do
  #   pipe_through :api
  # end
end
