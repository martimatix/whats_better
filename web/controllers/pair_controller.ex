defmodule WhatsBetter.PairController do
  use WhatsBetter.Web, :controller
  alias WhatsBetter.Pair

  def show(conn, %{"id" => id}) do
    things = Pair.get_things_with_votes(id)
    render conn, "show.html", things: things
  end
end
