defmodule BracketeerWeb.HelloController do
    use BracketeerWeb, :controller

    def index(conn, _params) do
        render(conn, "index.html")
    end

    def show(conn, %{"code" => code}) do
        render(conn, "show.html", code: code)
    end
end