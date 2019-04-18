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

  describe "scoreboards" do
    alias Bracketeer.Rooms.Scoreboard

    @valid_attrs %{byes: 42, matches: 42, score: 42}
    @update_attrs %{byes: 43, matches: 43, score: 43}
    @invalid_attrs %{byes: nil, matches: nil, score: nil}

    def scoreboard_fixture(attrs \\ %{}) do
      {:ok, scoreboard} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_scoreboard()

      scoreboard
    end

    test "list_scoreboards/0 returns all scoreboards" do
      scoreboard = scoreboard_fixture()
      assert Rooms.list_scoreboards() == [scoreboard]
    end

    test "get_scoreboard!/1 returns the scoreboard with given id" do
      scoreboard = scoreboard_fixture()
      assert Rooms.get_scoreboard!(scoreboard.id) == scoreboard
    end

    test "create_scoreboard/1 with valid data creates a scoreboard" do
      assert {:ok, %Scoreboard{} = scoreboard} = Rooms.create_scoreboard(@valid_attrs)
      assert scoreboard.byes == 42
      assert scoreboard.matches == 42
      assert scoreboard.score == 42
    end

    test "create_scoreboard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_scoreboard(@invalid_attrs)
    end

    test "update_scoreboard/2 with valid data updates the scoreboard" do
      scoreboard = scoreboard_fixture()
      assert {:ok, %Scoreboard{} = scoreboard} = Rooms.update_scoreboard(scoreboard, @update_attrs)
      assert scoreboard.byes == 43
      assert scoreboard.matches == 43
      assert scoreboard.score == 43
    end

    test "update_scoreboard/2 with invalid data returns error changeset" do
      scoreboard = scoreboard_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_scoreboard(scoreboard, @invalid_attrs)
      assert scoreboard == Rooms.get_scoreboard!(scoreboard.id)
    end

    test "delete_scoreboard/1 deletes the scoreboard" do
      scoreboard = scoreboard_fixture()
      assert {:ok, %Scoreboard{}} = Rooms.delete_scoreboard(scoreboard)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_scoreboard!(scoreboard.id) end
    end

    test "change_scoreboard/1 returns a scoreboard changeset" do
      scoreboard = scoreboard_fixture()
      assert %Ecto.Changeset{} = Rooms.change_scoreboard(scoreboard)
    end
  end

  describe "matches" do
    alias Bracketeer.Rooms.Match

    @valid_attrs %{draw: true}
    @update_attrs %{draw: false}
    @invalid_attrs %{draw: nil}

    def match_fixture(attrs \\ %{}) do
      {:ok, match} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_match()

      match
    end

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Rooms.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Rooms.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Rooms.create_match(@valid_attrs)
      assert match.draw == true
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, %Match{} = match} = Rooms.update_match(match, @update_attrs)
      assert match.draw == false
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_match(match, @invalid_attrs)
      assert match == Rooms.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Rooms.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Rooms.change_match(match)
    end
  end
end
