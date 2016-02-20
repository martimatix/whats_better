defmodule WhatsBetter.PageController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing
  alias WhatsBetter.Pair

  def index(conn, _params) do
    [thing_1, thing_2] = Thing.get_two_random

    render conn, "index.html",
      thing_1: thing_1,
      thing_2: thing_2
  end

  def vote(conn, params) do
    pair_id = Pair.vote(params["ballot"])
    redirect(conn, to: pair_path(conn, :show, pair_id))
  end
end
