defmodule BracketeerWeb.PageController do
  use BracketeerWeb, :controller

  def index(conn, _params) do
    conn
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

  def goto(conn, :code) do
    BracketeerWeb.BracketController.get_bracket(conn, :code)
  end
end
