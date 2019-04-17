defmodule Bracketeer.Rooms.Bracket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "brackets" do
    field :edit_key, :string
    field :name, :string
    field :code, :string

    timestamps()
  end

  @doc false
  def changeset(bracket, attrs) do
    bracket
    |> cast(attrs, [:name, :edit_key, :code])
    |> validate_required([:name, :edit_key, :code])
    |> unique_constraint(:name, :code)
  end
end
