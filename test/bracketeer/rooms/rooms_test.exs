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

  describe "participants" do
    alias Bracketeer.Rooms.Participant

    @valid_attrs %{name: "some name", rating: 42, seed: 42}
    @update_attrs %{name: "some updated name", rating: 43, seed: 43}
    @invalid_attrs %{name: nil, rating: nil, seed: nil}

    def participant_fixture(attrs \\ %{}) do
      {:ok, participant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_participant()

      participant
    end

    test "list_participants/0 returns all participants" do
      participant = participant_fixture()
      assert Rooms.list_participants() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Rooms.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      assert {:ok, %Participant{} = participant} = Rooms.create_participant(@valid_attrs)
      assert participant.name == "some name"
      assert participant.rating == 42
      assert participant.seed == 42
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{} = participant} = Rooms.update_participant(participant, @update_attrs)
      assert participant.name == "some updated name"
      assert participant.rating == 43
      assert participant.seed == 43
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_participant(participant, @invalid_attrs)
      assert participant == Rooms.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Rooms.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Rooms.change_participant(participant)
    end
  end

  describe "matches" do
    alias Bracketeer.Rooms.Match

    @valid_attrs %{away_score: 42, home_score: 42}
    @update_attrs %{away_score: 43, home_score: 43}
    @invalid_attrs %{away_score: nil, home_score: nil}

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
      assert match.away_score == 42
      assert match.home_score == 42
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, %Match{} = match} = Rooms.update_match(match, @update_attrs)
      assert match.away_score == 43
      assert match.home_score == 43
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
