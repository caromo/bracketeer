defmodule BracketeerWeb.HelloController do
    use BracketeerWeb, :controller

    plug :assign_welcome_message, "Welcome Back" when action in [:index, :show]

    def index(conn, _params) do
        conn
        |> assign(:message, "Welcome Forward")
        |> render("index.html")
    end

    defp assign_welcome_message(conn, msg) do
        assign(conn, :message, msg)
    end

    def show(conn, %{"code" => code}) do
        render(conn, "show.html", code: code)
    end


end
