defmodule Bracketeer.Rooms.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :draw, :boolean, default: false
    belongs_to :bracket, Bracketeer.Rooms.Bracket
    field :winner_id, :id
    field :loser_id, :id
    field :winner_score, :integer
    field :loser_score, :integer

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:draw, :winner_id, :loser_id,:bracket_id, :winner_score, :loser_score])
    |> foreign_key_constraint(:winner_id)
    |> foreign_key_constraint(:loser_id)
    |> foreign_key_constraint(:bracket_id)
    |> check_constraint(:winner_score, name: :winner_must_win)
    |> validate_required([:draw])
    
  end
end
