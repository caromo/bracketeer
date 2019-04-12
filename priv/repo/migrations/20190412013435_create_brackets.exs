defmodule Bracketeer.Repo.Migrations.CreateBrackets do
  use Ecto.Migration

  def change do
    create table(:brackets) do
      add :name, :string
      add :edit_key, :string
      add :code, :string

      timestamps()
    end

    create unique_index(:brackets, [:name, :code])
  end
end
