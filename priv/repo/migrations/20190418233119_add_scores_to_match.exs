defmodule Bracketeer.Repo.Migrations.AddScoresToMatch do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :winner_score, :integer
      add :loser_score, :integer
    end

    create constraint(:matches, :winner_must_win, check: "winner_score >= loser_score")
  end
end
