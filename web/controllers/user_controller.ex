defmodule WhatsBetter.UserController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.User

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    user_params = for {key, val} <- params["user"], into: %{}, do: {String.to_atom(key), val}
    user = struct(User, user_params)
    User.save(user)
    redirect(conn, to: "/")
  end
end
