defmodule WhatsBetter.UserController do
  use WhatsBetter.Web, :controller

  alias WhatsBetter.User

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    user_params = for {key, val} <- params["user"], into: %{}, do: {String.to_atom(key), val}
    # TODO: improve on pattern below - hard to read
    user = User.save(struct(User, user_params))
    conn
    |> WhatsBetter.Auth.login(user)
    |> put_flash(:info, "#{user.name} created!")
    |> redirect(to: "/")
  end
end
