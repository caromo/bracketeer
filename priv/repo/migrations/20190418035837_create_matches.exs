defmodule Bracketeer.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :draw, :boolean, default: false, null: false
      add :bracket_id, references(:brackets, on_delete: :delete_all)
      add :winner_id, references(:players, on_delete: :delete_all)
      add :loser_id, references(:players, on_delete: :delete_all)

      timestamps()
    end
    create index(:matches, [:bracket_id])
    create index(:matches, [:winner_id])
    create index(:matches, [:loser_id])
  end
end
