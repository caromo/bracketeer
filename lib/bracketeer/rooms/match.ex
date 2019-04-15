defmodule Bracketeer.Rooms.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :away_score, :integer
    field :home_score, :integer
    field :home_id, :id
    field :away_id, :id
    belongs_to :bracket, Bracketeer.Rooms.Bracket

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:home_score, :away_score])
    |> validate_required([:home_score, :away_score])
  end
end
