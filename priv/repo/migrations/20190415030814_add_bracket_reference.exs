defmodule Bracketeer.Repo.Migrations.AddBracketReference do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :bracket_id, references(:brackets, on_delete: :nothing)
    end

    create index(:matches, [:bracket_id])
  end
end
