defmodule Bracketeer.Rooms.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    field :rating, :integer
    belongs_to :bracket, Bracketeer.Rooms.Bracket
    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :rating, :bracket_id])
    |> foreign_key_constraint(:bracket_id)
    |> validate_required([:name, :rating])
    
  end
end
