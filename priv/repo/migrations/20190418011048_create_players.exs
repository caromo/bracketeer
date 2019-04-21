defmodule Bracketeer.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :rating, :integer
      add :bracket_id, references(:brackets, on_delete: :delete_all)

      timestamps()
    end

    create index(:players, [:bracket_id])
  end
end
