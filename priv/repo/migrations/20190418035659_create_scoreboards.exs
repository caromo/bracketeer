defmodule Bracketeer.Repo.Migrations.CreateScoreboards do
  use Ecto.Migration

  def change do
    create table(:scoreboards) do
      add :score, :integer
      add :matches, :integer
      add :byes, :integer
      add :bracket_id, references(:brackets, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:scoreboards, [:bracket_id])
    create index(:scoreboards, [:player_id])
  end
end
