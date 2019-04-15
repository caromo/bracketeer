defmodule BracketeerWeb.PageController do
  use BracketeerWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def test(conn, _params) do
    conn |> render("test.html")
  end

  #https://hexdocs.pm/phoenix/controllers.html#content
  # ! conn |> put_status

end
