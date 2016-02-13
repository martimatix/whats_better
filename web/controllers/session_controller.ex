defmodule WhatsBetter.SessionController do
  use WhatsBetter.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  # TODO: Validate uniqueness of email
  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case WhatsBetter.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> WhatsBetter.Auth.logout()
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
