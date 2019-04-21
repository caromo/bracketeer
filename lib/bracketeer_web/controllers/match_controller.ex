defmodule BracketeerWeb.MatchController do
  use BracketeerWeb, :controller

  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Match

  action_fallback BracketeerWeb.FallbackController

  def index(conn, _params) do
    matches = Rooms.list_matches()
    render(conn, "index.json", matches: matches)
  end

  def create(conn, %{"match" => match_params}) do
    with {:ok, %Match{} = match} <- Rooms.create_match(match_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.match_path(conn, :show, match))
      |> render("show.json", match: match)
    end
  end

  def report_results(conn, %{"match" => match_params, "xid" => player_one, "yid" => player_two, "bid" => room_id}) do
    Rooms.create_match(match_params)
  end

  def show(conn, %{"id" => id}) do
    match = Rooms.get_match!(id)
    render(conn, "show.json", match: match)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Rooms.get_match!(id)

    with {:ok, %Match{} = match} <- Rooms.update_match(match, match_params) do
      render(conn, "show.json", match: match)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Rooms.get_match!(id)

    with {:ok, %Match{}} <- Rooms.delete_match(match) do
      send_resp(conn, :no_content, "")
    end
  end
end
