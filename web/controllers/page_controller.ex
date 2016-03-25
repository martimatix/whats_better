defmodule WhatsBetter.PageController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing
  alias WhatsBetter.Pair
  alias WhatsBetter.Ranking
  alias WhatsBetter.Router

  plug :authenticate_user when action in [:vote]

  def index(conn, _params) do
    [thing_1, thing_2] = Thing.get_two_random
    domain = Router.Helpers.url(conn)
    case _params["pair_id"] do
      nil ->
        render conn, "index.html",
          thing_1: thing_1,
          thing_2: thing_2
      _ ->
        previous_things = Pair.get_things_with_votes(_params["pair_id"])
        [best_things, worst_things] = [nil, nil]
        render conn, "main.html",
        thing_1: thing_1,
        thing_2: thing_2,
        previous_things: previous_things,
        pair_id: _params["pair_id"],
        domain: domain
    end
  end

  def vote(conn, params) do
    pair_id = Pair.vote(params["ballot"])
    redirect(conn, to: page_path(conn, :index, pair_id: pair_id))
  end

  def recent_comments(conn, _params) do
    render conn, "recent_comments.html"
  end
end
