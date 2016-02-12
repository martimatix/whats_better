defmodule WhatsBetter.Auth do
  import Plug.Conn
  alias WhatsBetter.User

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && User.get(user_id)
    assign(conn, :current_user, user)
  end
end
