defmodule Wowtrade.Repo.Migrations.CreateRecipesReagents do
  use Ecto.Migration

  def change do
    create table(:recipes_reagents) do
      add :amount, :integer
      add :spell_id, :integer
      add :item_id, references(:items, column: :item_id, on_delete: :delete_all)
      add :recipe_id, references(:recipes, on_delete: :delete_all)
    end

    create index(:recipes_reagents, [:item_id])
    create index(:recipes_reagents, [:recipe_id])
    create unique_index(:recipes_reagents, [:item_id, :spell_id])
  end
end
