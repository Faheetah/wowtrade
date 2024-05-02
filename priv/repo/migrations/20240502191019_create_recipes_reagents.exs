defmodule Wowtrade.Repo.Migrations.CreateRecipesReagents do
  use Ecto.Migration

  def change do
    create table(:recipes_reagents) do
      add :amount, :integer
      add :item_id, references(:items, on_delete: :delete_all)
      add :recipe_id, references(:recipes, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:recipes_reagents, [:item_id])
    create index(:recipes_reagents, [:recipe_id])
  end
end
