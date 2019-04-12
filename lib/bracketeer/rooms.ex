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
    Repo.all(Bracket)
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
end
