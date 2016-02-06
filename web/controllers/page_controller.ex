defmodule WhatsBetter.PageController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.Thing

  def index(conn, _params) do
    [first_thing, second_thing] = Thing.get_two_random
    IO.inspect first_thing

    render conn, "index.html",
      first_thing: first_thing,
      second_thing: second_thing
  end
end
