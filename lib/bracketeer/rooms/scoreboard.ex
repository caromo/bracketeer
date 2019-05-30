defmodule Bracketeer.Rooms.Scoreboard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scoreboards" do
    field :byes, :integer
    field :matches, :integer
    field :score, :integer
    belongs_to :bracket, Bracketeer.Rooms.Bracket
    belongs_to :player, Bracketeer.Rooms.Player

    timestamps()
  end

  @doc false
  def changeset(scoreboard, attrs) do
    scoreboard
    |> cast(attrs, [:score, :matches, :byes, :bracket_id, :player_id])
    |> foreign_key_constraint(:bracket_id)
    |> foreign_key_constraint(:player_id)
    |> validate_required([:score, :matches, :byes])
    
  end
end
