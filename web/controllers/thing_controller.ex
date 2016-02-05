defmodule WhatsBetter.ThingController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing

  require IEx

  def index(conn, _params ) do
    things = Thing.get_all
    render(conn, "index.html", things: things)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    redirect conn, to: "/things"
  end
end
