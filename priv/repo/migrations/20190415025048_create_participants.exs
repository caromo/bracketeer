defmodule Bracketeer.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :name, :string
      add :rating, :integer
      add :seed, :integer

      timestamps()
    end

  end
end
