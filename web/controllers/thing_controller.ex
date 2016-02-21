defmodule WhatsBetter.ThingController do
  use WhatsBetter.Web, :controller
  alias WhatsBetter.Thing
  
  plug :authenticate_user when action in [:index, :new]

  def index(conn, _params ) do
    things = Thing.get_all
    render(conn, "index.html", things: things)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    thing_params = for {key, val} <- params["thing"], into: %{}, do: {String.to_atom(key), val}
    thing = struct(Thing, thing_params)
    Thing.save(thing)
    redirect(conn, to: "/things")
  end
end
