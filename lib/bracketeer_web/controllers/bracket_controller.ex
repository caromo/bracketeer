defmodule BracketeerWeb.BracketController do
  require IEx
  use BracketeerWeb, :controller

  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Bracket

  def index(conn, _params) do
    brackets = Rooms.list_brackets()
    render(conn, "index.html", brackets: brackets)
  end

  def new(conn, _params) do
    changeset = Rooms.change_bracket(%Bracket{})
    render(conn, "new.html", changeset: changeset)
  end

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

  def show(conn, %{"id" => id}) do
    bracket = Rooms.get_bracket!(id)
    IEx.pry()
    conn
    |> assign(:curr_id, id)
    |> render( "show.html", bracket: bracket)
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
        conn
        |> render("show.html", bracket: bracket)
    end

  end
end
