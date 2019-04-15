defmodule Bracketeer.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :home_score, :integer
      add :away_score, :integer
      add :home_id, references(:participants, on_delete: :nothing)
      add :away_id, references(:participants, on_delete: :nothing)

      timestamps()
    end

    create index(:matches, [:home_id])
    create index(:matches, [:away_id])
  end
end
