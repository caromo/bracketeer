defmodule BracketeerWeb.BracketController do
  require IEx
  use BracketeerWeb, :controller
  import Plug.Conn
  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Bracket
  alias Bracketeer.Rooms.Match

  def index(conn, _params) do
    brackets = Rooms.list_brackets()
    render(conn, "index.html", brackets: brackets)
  end

  def new(conn, _params) do
    changeset = Rooms.change_bracket(%Bracket{})
    render(conn, "new.html", changeset: changeset)
  end

  # TODO: Implement this later...
  # def update_rankings(conn, %{"id" => id}) do
  #   bracket = Rooms.get_bracket!(id)
  #   list = Rooms.generate_rankings(id)
  #   rankings = split_rankings_into_matches(list)
  #   conn
  #   |> put_session(:curr, rankings)
  #   |> redirect(to: Routes.bracket_path(conn, :show, bracket))
  # end

  def create(conn, %{"bracket" => bracket_params}) do
    case Rooms.create_bracket(bracket_params) do
      {:ok, bracket} ->
        conn
        |> put_flash(:info, "Bracket created successfully.")
        |> redirect(to: Routes.bracket_path(conn, :show, bracket))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def make_match(conn, %{"match" => match_params}) do
    cs = Rooms.handle_match_results(match_params)

    case Rooms.create_match(cs) do
      {:ok, match} ->
        Rooms.update_scores(cs)

        conn
        |> put_flash(:info, "Match Reported")
        |> redirect(to: Routes.bracket_path(conn, :show, Rooms.get_bracket!(match.bracket_id)))

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, "Failed to create match")
        |> redirect(to: Routes.bracket_path(conn, :show, Rooms.get_bracket!(cs.bracket_id)))
    end

    conn
    |> redirect(to: Routes.bracket_path(conn, :index))
  end

  def report_match(conn, %{
        "xid" => player_one,
        "yid" => player_two,
        "bid" => room_id
      }) do
    changeset = Rooms.change_match(%Match{bracket_id: room_id})

    render(conn, "mnew.html", changeset: changeset, xid: player_one, yid: player_two, bid: room_id)
  end

  def report_bye(conn, %{"id" => id}) do
    player = Rooms.get_player!(id)
    Rooms.give_bye_to_player(id)

    conn
    |> redirect(to: Routes.bracket_path(conn, :show, player.bracket_id))
  end

  # TODO: Change this from players to id's (ints) so we can
  # TODO: Keep this in the conn.assigns (These objects are more than 4kb!!!)  

  def process_pair([x, y]) do
    [x_player: x.player, y_player: y.player, tid: x.bracket]
  end

  def process_pair([x]) do
    [x_player: x.player, tid: x.bracket]
  end

  def split_rankings_into_matches(rankings) do
    pairs = Enum.chunk_every(rankings, 2)
    Enum.map(pairs, fn x -> process_pair(x) end)
  end

  def show(conn, %{"id" => id}) do
    bracket = Rooms.get_bracket!(id)
    list = Rooms.generate_rankings(id)
    rankings = split_rankings_into_matches(list)

    conn
    |> assign(:curr_id, id)
    |> render("show.html", bracket: bracket, rankings: rankings)
  end

  def edit(conn, %{"id" => id}) do
    bracket = Rooms.get_bracket!(id)
    changeset = Rooms.change_bracket(bracket)
    render(conn, "edit.html", bracket: bracket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bracket" => bracket_params}) do
    bracket = Rooms.get_bracket!(id)

    case Rooms.update_bracket(bracket, bracket_params) do
      {:ok, bracket} ->
        conn
        |> put_flash(:info, "Bracket updated successfully.")
        |> redirect(to: Routes.bracket_path(conn, :show, bracket))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bracket: bracket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bracket = Rooms.get_bracket!(id)
    {:ok, _bracket} = Rooms.delete_bracket(bracket)

    conn
    |> put_flash(:info, "Bracket deleted successfully.")
    |> redirect(to: Routes.bracket_path(conn, :index))
  end

  def get_bracket(conn, %{"code" => code}) do
    bracket = Rooms.get_bracket_by_code!(code)

    case bracket do
      nil ->
        conn
        |> put_flash(:error, "Error: Invalid Room Code")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()

      _ ->
        list = Rooms.generate_rankings(bracket.id)
        rankings = split_rankings_into_matches(list)

        conn
        |> render("show.html", bracket: bracket, rankings: rankings)
    end
  end
end
