defmodule Wowtrade.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :class, :string
      add :class_lower, :string
      add :subclass, :string
      add :subclass_lower, :string
    end

    create index(:categories, [:class])
    create index(:categories, [:subclass])
    create unique_index(:categories, [:class, :subclass])
  end
end
