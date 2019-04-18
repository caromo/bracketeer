defmodule Bracketeer.RoomsTest do
  use Bracketeer.DataCase

  alias Bracketeer.Rooms

  describe "brackets" do
    alias Bracketeer.Rooms.Bracket

    @valid_attrs %{edit_key: "some edit_key", name: "some name"}
    @update_attrs %{edit_key: "some updated edit_key", name: "some updated name"}
    @invalid_attrs %{edit_key: nil, name: nil}

    def bracket_fixture(attrs \\ %{}) do
      {:ok, bracket} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_bracket()

      bracket
    end

    test "list_brackets/0 returns all brackets" do
      bracket = bracket_fixture()
      assert Rooms.list_brackets() == [bracket]
    end

    test "get_bracket!/1 returns the bracket with given id" do
      bracket = bracket_fixture()
      assert Rooms.get_bracket!(bracket.id) == bracket
    end

    test "create_bracket/1 with valid data creates a bracket" do
      assert {:ok, %Bracket{} = bracket} = Rooms.create_bracket(@valid_attrs)
      assert bracket.edit_key == "some edit_key"
      assert bracket.name == "some name"
    end

    test "create_bracket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_bracket(@invalid_attrs)
    end

    test "update_bracket/2 with valid data updates the bracket" do
      bracket = bracket_fixture()
      assert {:ok, %Bracket{} = bracket} = Rooms.update_bracket(bracket, @update_attrs)
      assert bracket.edit_key == "some updated edit_key"
      assert bracket.name == "some updated name"
    end

    test "update_bracket/2 with invalid data returns error changeset" do
      bracket = bracket_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_bracket(bracket, @invalid_attrs)
      assert bracket == Rooms.get_bracket!(bracket.id)
    end

    test "delete_bracket/1 deletes the bracket" do
      bracket = bracket_fixture()
      assert {:ok, %Bracket{}} = Rooms.delete_bracket(bracket)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_bracket!(bracket.id) end
    end

    test "change_bracket/1 returns a bracket changeset" do
      bracket = bracket_fixture()
      assert %Ecto.Changeset{} = Rooms.change_bracket(bracket)
    end
  end

  describe "players" do
    alias Bracketeer.Rooms.Player

    @valid_attrs %{name: "some name", rating: 42}
    @update_attrs %{name: "some updated name", rating: 43}
    @invalid_attrs %{name: nil, rating: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Rooms.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Rooms.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Rooms.create_player(@valid_attrs)
      assert player.name == "some name"
      assert player.rating == 42
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, %Player{} = player} = Rooms.update_player(player, @update_attrs)
      assert player.name == "some updated name"
      assert player.rating == 43
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_player(player, @invalid_attrs)
      assert player == Rooms.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Rooms.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Rooms.change_player(player)
    end
  end
end
