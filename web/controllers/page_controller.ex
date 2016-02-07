defmodule WhatsBetter.PageController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing

  def index(conn, _params) do
    [thing_1, thing_2] = Thing.get_two_random

    render conn, "index.html",
      thing_1: thing_1,
      thing_2: thing_2
  end

  def vote(conn, params) do
    IO.inspect(params)
    redirect(conn, to: "/")
  end
end
