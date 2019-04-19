defmodule Bracketeer.Rooms do
  @moduledoc """
  The Rooms context.
  """
  require IEx
  import Ecto.Query, warn: false
  alias Bracketeer.Repo

  alias Bracketeer.Rooms.Bracket
  alias Bracketeer.Rooms.Scoreboard
  alias Bracketeer.Rooms.Player
  alias Bracketeer.Rooms.Match

  @doc """
  Returns the list of brackets.

  ## Examples

      iex> list_brackets()
      [%Bracket{}, ...]

  """
  def list_brackets do
    Bracket
    |> Repo.all()
  end

  @doc """
  Gets a single bracket.

  Raises `Ecto.NoResultsError` if the Bracket does not exist.

  ## Examples

      iex> get_bracket!(123)
      %Bracket{}

      iex> get_bracket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bracket!(id), do: Repo.get!(Bracket, id)
  def get_bracket(id), do: Repo.get(Bracket, id)

  def get_bracket_by_code!(code), do: Repo.get_by(Bracket, code: code)

  @doc """
  Creates a bracket.

  ## Examples

      iex> create_bracket(%{field: value})
      {:ok, %Bracket{}}

      iex> create_bracket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bracket(attrs \\ %{}) do
    %Bracket{code: RandomBytes.base16(3)}
    |> Bracket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bracket.

  ## Examples

      iex> update_bracket(bracket, %{field: new_value})
      {:ok, %Bracket{}}

      iex> update_bracket(bracket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bracket(%Bracket{} = bracket, attrs) do
    bracket
    |> Bracket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bracket.

  ## Examples

      iex> delete_bracket(bracket)
      {:ok, %Bracket{}}

      iex> delete_bracket(bracket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bracket(%Bracket{} = bracket) do
    Repo.delete(bracket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bracket changes.

  ## Examples

      iex> change_bracket(bracket)
      %Ecto.Changeset{source: %Bracket{}}

  """
  def change_bracket(%Bracket{} = bracket) do
    Bracket.changeset(bracket, %{})
  end

  alias Bracketeer.Rooms.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Player
    |> Repo.all()
    |> preload_bracket()
  end

  def list_players_by_bracket(bracket) do
    Repo.all(from u in Scoreboard, join: p in Player, on: u.player_id ==  p.id, order_by: [desc: u.score, desc: u.matches, desc: p.rating], where: u.bracket_id == ^bracket)
    # Repo.all(from u in Scoreboard, p in Player , order_by: [desc: u.score, desc: u.matches], where: u.bracket_id == ^bracket )
    |> preload_bracket()
    |> preload_player()
  end


  def generate_pairings(id) do
    Repo.all(from p1 in Scoreboard, join: p2 in Scoreboard, on: p1.score == p2.score, distinct: true, select: %{p1: p1, p2: p2}, where: (p1.bracket_id == ^id) and (p1.score == p2.score) and (p1.id > p2.id))    
    |> preload_bracket()
    |> preload_player()

  end



  def count_players(bracket) do
    bracket
    |> list_players_by_bracket()
    |> length()
  end

  def round_count(bracket) do
    len = bracket
    |> list_players_by_bracket()
    |> length()

    case len do
      0 -> 0
      _ -> :math.log(len) / :math.log(2)
      |> Decimal.from_float()
      |> Decimal.round(0, :up)
      |> Decimal.to_integer()
    end

  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end

  def preload_bracket(b) do
    Repo.preload(b, :bracket)
  end
  def preload_player(p) do
    Repo.preload(p, :player)
  end

  alias Bracketeer.Rooms.Scoreboard

  @doc """
  Returns the list of scoreboards.

  ## Examples

      iex> list_scoreboards()
      [%Scoreboard{}, ...]

  """
  def list_scoreboards do
    Repo.all(Scoreboard)
  end

  @doc """
  Gets a single scoreboard.

  Raises `Ecto.NoResultsError` if the Scoreboard does not exist.

  ## Examples

      iex> get_scoreboard!(123)
      %Scoreboard{}

      iex> get_scoreboard!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scoreboard!(id), do: Repo.get!(Scoreboard, id)

  @doc """
  Creates a scoreboard.

  ## Examples

      iex> create_scoreboard(%{field: value})
      {:ok, %Scoreboard{}}

      iex> create_scoreboard(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scoreboard(attrs \\ %{}) do
    %Scoreboard{byes: 0, matches: 0, score: 0}
    |> Scoreboard.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scoreboard.

  ## Examples

      iex> update_scoreboard(scoreboard, %{field: new_value})
      {:ok, %Scoreboard{}}

      iex> update_scoreboard(scoreboard, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scoreboard(%Scoreboard{} = scoreboard, attrs) do
    scoreboard
    |> Scoreboard.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Scoreboard.

  ## Examples

      iex> delete_scoreboard(scoreboard)
      {:ok, %Scoreboard{}}

      iex> delete_scoreboard(scoreboard)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scoreboard(%Scoreboard{} = scoreboard) do
    Repo.delete(scoreboard)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scoreboard changes.

  ## Examples

      iex> change_scoreboard(scoreboard)
      %Ecto.Changeset{source: %Scoreboard{}}

  """
  def change_scoreboard(%Scoreboard{} = scoreboard) do
    Scoreboard.changeset(scoreboard, %{})
  end

  alias Bracketeer.Rooms.Match

  @doc """
  Returns the list of matches.

  ## Examples

      iex> list_matches()
      [%Match{}, ...]

  """
  def list_matches do
    Repo.all(Match)
  end

  @doc """
  Gets a single match.

  Raises `Ecto.NoResultsError` if the Match does not exist.

  ## Examples

      iex> get_match!(123)
      %Match{}

      iex> get_match!(456)
      ** (Ecto.NoResultsError)

  """
  def get_match!(id), do: Repo.get!(Match, id)

  @doc """
  Creates a match.

  ## Examples

      iex> create_match(%{field: value})
      {:ok, %Match{}}

      iex> create_match(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a match.

  ## Examples

      iex> update_match(match, %{field: new_value})
      {:ok, %Match{}}

      iex> update_match(match, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_match(%Match{} = match, attrs) do
    match
    |> Match.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Match.

  ## Examples

      iex> delete_match(match)
      {:ok, %Match{}}

      iex> delete_match(match)
      {:error, %Ecto.Changeset{}}

  """
  def delete_match(%Match{} = match) do
    Repo.delete(match)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking match changes.

  ## Examples

      iex> change_match(match)
      %Ecto.Changeset{source: %Match{}}

  """
  def change_match(%Match{} = match) do
    Match.changeset(match, %{})
  end
end
