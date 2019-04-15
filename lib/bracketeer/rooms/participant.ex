defmodule Bracketeer.Rooms.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participants" do
    field :name, :string
    field :rating, :integer
    field :seed, :integer

    timestamps()
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:name, :rating])
    |> validate_required([:name, :rating])
  end
end
