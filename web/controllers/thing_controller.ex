defmodule WhatsBetter.ThingController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing

  def index(conn, _params ) do
    case authenticate(conn) do
      %Plug.Conn{halted: true} = conn ->
        conn
      conn ->
        things = Thing.get_all
        render(conn, "index.html", things: things)
    end
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

  defp authenticate(conn) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
