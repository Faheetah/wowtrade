defmodule Wowtrade.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :class, :string
      add :subclass, :string
    end

    create index(:categories, [:class])
    create index(:categories, [:subclass])
  end
end
