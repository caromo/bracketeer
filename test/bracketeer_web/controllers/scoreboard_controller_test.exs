defmodule BracketeerWeb.ScoreboardControllerTest do
  use BracketeerWeb.ConnCase

  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Scoreboard

  @create_attrs %{
    byes: 42,
    matches: 42,
    score: 42
  }
  @update_attrs %{
    byes: 43,
    matches: 43,
    score: 43
  }
  @invalid_attrs %{byes: nil, matches: nil, score: nil}

  def fixture(:scoreboard) do
    {:ok, scoreboard} = Rooms.create_scoreboard(@create_attrs)
    scoreboard
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scoreboards", %{conn: conn} do
      conn = get(conn, Routes.scoreboard_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create scoreboard" do
    test "renders scoreboard when data is valid", %{conn: conn} do
      conn = post(conn, Routes.scoreboard_path(conn, :create), scoreboard: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.scoreboard_path(conn, :show, id))

      assert %{
               "id" => id,
               "byes" => 42,
               "matches" => 42,
               "score" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.scoreboard_path(conn, :create), scoreboard: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update scoreboard" do
    setup [:create_scoreboard]

    test "renders scoreboard when data is valid", %{conn: conn, scoreboard: %Scoreboard{id: id} = scoreboard} do
      conn = put(conn, Routes.scoreboard_path(conn, :update, scoreboard), scoreboard: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.scoreboard_path(conn, :show, id))

      assert %{
               "id" => id,
               "byes" => 43,
               "matches" => 43,
               "score" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, scoreboard: scoreboard} do
      conn = put(conn, Routes.scoreboard_path(conn, :update, scoreboard), scoreboard: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete scoreboard" do
    setup [:create_scoreboard]

    test "deletes chosen scoreboard", %{conn: conn, scoreboard: scoreboard} do
      conn = delete(conn, Routes.scoreboard_path(conn, :delete, scoreboard))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.scoreboard_path(conn, :show, scoreboard))
      end
    end
  end

  defp create_scoreboard(_) do
    scoreboard = fixture(:scoreboard)
    {:ok, scoreboard: scoreboard}
  end
end
