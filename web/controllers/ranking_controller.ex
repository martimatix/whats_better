defmodule WhatsBetter.RankingController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Ranking

  def index(conn, _params) do
    best_things = Ranking.top
    worst_things = Ranking.bottom

    render conn, "index.html",
      best_things: best_things,
      worst_things: worst_things
  end
end
