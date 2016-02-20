defmodule WhatsBetter.PairController do
  use WhatsBetter.Web, :controller
  alias WhatsBetter.Pair

  def show(conn, %{"id" => id}) do
    IO.puts "hitting here"
    pair = Pair.get(id)
    render conn, "show.html", pair: pair
  end
end
