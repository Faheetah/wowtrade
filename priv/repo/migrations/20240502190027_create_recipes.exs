defmodule Wowtrade.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :item_id, :integer
      add :min_amount, :integer
      add :max_amount, :integer
      add :required_skill, :integer
      add :category, :string

      timestamps(type: :utc_datetime)
    end
  end
end
