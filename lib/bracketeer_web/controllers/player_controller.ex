defmodule BracketeerWeb.PlayerController do
  require IEx
  use BracketeerWeb, :controller

  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Player

  plug :load_rooms when action in [:new, :create, :edit, :update, :index, :index_for_tourney]

  def index(conn, _params) do
    players = Rooms.list_players()
    render(conn, "index.html", players: players)
  end

  def index_for_tourney(conn, %{"id" => id}) do
    IEx.pry()
    players = Rooms.list_players_by_bracket(id)
    render(conn, "bindex.html", players: players, id: id)
  end

  def new(conn, _params) do
    changeset = Rooms.change_player(%Player{})
    render(conn, "new.html", changeset: changeset)
  end
  def create(conn, %{"player" => player_params}) do
    case Rooms.create_player(player_params) do
      {:ok, player} ->
        Rooms.create_scoreboard(%{"bracket_id" => player.bracket_id, "player_id" => player.id})
        IO.puts("Added room")
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: Routes.player_path(conn, :show, player))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Rooms.get_player!(id)
    render(conn, "show.html", player: player)
  end

  def edit(conn, %{"id" => id}) do
    player = Rooms.get_player!(id)
    changeset = Rooms.change_player(player)
    render(conn, "edit.html", player: player, changeset: changeset)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Rooms.get_player!(id)

    case Rooms.update_player(player, player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: Routes.player_path(conn, :show, player))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", player: player, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Rooms.get_player!(id)
    {:ok, _player} = Rooms.delete_player(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: Routes.player_path(conn, :index))
  end

  defp load_rooms(conn, _) do

    assign(conn, :rooms, Rooms.list_brackets())
  end
end
