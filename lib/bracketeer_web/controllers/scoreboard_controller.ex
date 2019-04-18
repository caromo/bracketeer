defmodule BracketeerWeb.ScoreboardController do
  use BracketeerWeb, :controller

  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Scoreboard

  action_fallback BracketeerWeb.FallbackController

  def index(conn, _params) do
    scoreboards = Rooms.list_scoreboards()
    render(conn, "index.json", scoreboards: scoreboards)
  end

  def create(conn, %{"scoreboard" => scoreboard_params}) do
    with {:ok, %Scoreboard{} = scoreboard} <- Rooms.create_scoreboard(scoreboard_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.scoreboard_path(conn, :show, scoreboard))
      |> render("show.json", scoreboard: scoreboard)
    end
  end

  def show(conn, %{"id" => id}) do
    scoreboard = Rooms.get_scoreboard!(id)
    render(conn, "show.json", scoreboard: scoreboard)
  end

  def update(conn, %{"id" => id, "scoreboard" => scoreboard_params}) do
    scoreboard = Rooms.get_scoreboard!(id)

    with {:ok, %Scoreboard{} = scoreboard} <- Rooms.update_scoreboard(scoreboard, scoreboard_params) do
      render(conn, "show.json", scoreboard: scoreboard)
    end
  end

  def delete(conn, %{"id" => id}) do
    scoreboard = Rooms.get_scoreboard!(id)

    with {:ok, %Scoreboard{}} <- Rooms.delete_scoreboard(scoreboard) do
      send_resp(conn, :no_content, "")
    end
  end
end
