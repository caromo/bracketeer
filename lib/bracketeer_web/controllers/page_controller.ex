defmodule BracketeerWeb.PageController do
  use BracketeerWeb, :controller

  def index(conn, _params) do
    conn
    # |> redirect(to: "/redirect_test")
    # |> put_layout("admin.html")
    # |> put_flash(:info, "Flash info here") # TODO: Remove this later
    # |> put_flash(:error, "Error found")    # TODO: This one too
    |> render("index.html")
  end

  def test(conn, _params) do
    conn |> render("test.html")
  end


  def redirect_test(conn, _params) do
    text(conn, "Redirecting")
  end
  #https://hexdocs.pm/phoenix/controllers.html#content
  # ! conn |> put_status
end
