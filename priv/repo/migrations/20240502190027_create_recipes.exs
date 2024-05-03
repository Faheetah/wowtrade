defmodule Wowtrade.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :item_id, :integer
      add :min_amount, :integer
      add :max_amount, :integer
      add :required_skill, :integer
      add :category, :string
    end

    create unique_index(:recipes, :item_id)
  end
end
