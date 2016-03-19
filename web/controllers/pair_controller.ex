defmodule WhatsBetter.PairController do
  use WhatsBetter.Web, :controller
  alias WhatsBetter.Pair

  def show(conn, %{"id" => id}) do
    things = Pair.get_things_with_votes(id)
    domain = Router.Helpers.url(conn)
    render conn, "show.html", things: things, pair_id: id, domain: domain
  end
end
