defmodule Bracketeer.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Bracketeer.Repo

  alias Bracketeer.Rooms.Bracket

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
    Repo.all(from p in Player, order_by: p.rating, where: p.bracket_id == ^bracket )
    |> preload_bracket()
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

    :math.log(len) / :math.log(2)
    |> Decimal.from_float()
    |> Decimal.round(0, :up)
    |> Decimal.to_integer()
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
end
