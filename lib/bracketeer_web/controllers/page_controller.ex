defmodule BracketeerWeb.PageController do
  use BracketeerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
