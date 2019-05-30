defmodule BracketeerWeb.PageControllerTest do
  use BracketeerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Bracketeer!"
  end
end
