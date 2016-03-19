defmodule WhatsBetter.PageController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing
  alias WhatsBetter.Pair
  alias WhatsBetter.Ranking

  plug :authenticate_user when action in [:vote]

  def index(conn, _params) do
    [thing_1, thing_2] = Thing.get_two_random

    case _params["pair_id"] do
      nil ->
        previous_things = :no_previous_pair
        best_things = Ranking.top
        worst_things = Ranking.bottom
      _ ->
        previous_things = Pair.get_things_with_votes(_params["pair_id"])
        [best_things, worst_things] = [nil, nil]
    end
    render conn, "index.html",
      thing_1: thing_1,
      thing_2: thing_2,
      best_things: best_things,
      worst_things: worst_things,
      previous_things: previous_things,
      pair_id: _params["pair_id"]
  end

  def vote(conn, params) do
    pair_id = Pair.vote(params["ballot"])
    redirect(conn, to: page_path(conn, :index, pair_id: pair_id))
  end

  def recent_comments(conn, _params) do
    render conn, "recent_comments.html"
  end
end
