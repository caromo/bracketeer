defmodule BracketeerWeb.BracketControllerTest do
  use BracketeerWeb.ConnCase

  alias Bracketeer.Rooms

  @create_attrs %{edit_key: "some edit_key", name: "some name"}
  @update_attrs %{edit_key: "some updated edit_key", name: "some updated name"}
  @invalid_attrs %{edit_key: nil, name: nil}

  def fixture(:bracket) do
    {:ok, bracket} = Rooms.create_bracket(@create_attrs)
    bracket
  end

  describe "index" do
    test "lists all brackets", %{conn: conn} do
      conn = get(conn, Routes.bracket_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Brackets"
    end
  end

  describe "new bracket" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bracket_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bracket"
    end
  end

  describe "create bracket" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bracket_path(conn, :create), bracket: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bracket_path(conn, :show, id)

      conn = get(conn, Routes.bracket_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bracket"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bracket_path(conn, :create), bracket: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bracket"
    end
  end

  describe "edit bracket" do
    setup [:create_bracket]

    test "renders form for editing chosen bracket", %{conn: conn, bracket: bracket} do
      conn = get(conn, Routes.bracket_path(conn, :edit, bracket))
      assert html_response(conn, 200) =~ "Edit Bracket"
    end
  end

  describe "update bracket" do
    setup [:create_bracket]

    test "redirects when data is valid", %{conn: conn, bracket: bracket} do
      conn = put(conn, Routes.bracket_path(conn, :update, bracket), bracket: @update_attrs)
      assert redirected_to(conn) == Routes.bracket_path(conn, :show, bracket)

      conn = get(conn, Routes.bracket_path(conn, :show, bracket))
      assert html_response(conn, 200) =~ "some updated edit_key"
    end

    test "renders errors when data is invalid", %{conn: conn, bracket: bracket} do
      conn = put(conn, Routes.bracket_path(conn, :update, bracket), bracket: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bracket"
    end
  end

  describe "delete bracket" do
    setup [:create_bracket]

    test "deletes chosen bracket", %{conn: conn, bracket: bracket} do
      conn = delete(conn, Routes.bracket_path(conn, :delete, bracket))
      assert redirected_to(conn) == Routes.bracket_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bracket_path(conn, :show, bracket))
      end
    end
  end

  defp create_bracket(_) do
    bracket = fixture(:bracket)
    {:ok, bracket: bracket}
  end
end
