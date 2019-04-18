defmodule Bracketeer.Rooms.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :draw, :boolean, default: false
    belongs_to :bracket, Bracketeer.Rooms.Bracket
    field :winner_id, :id
    field :loser_id, :id

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:draw])
    |> validate_required([:draw])
  end
end
