defmodule Wowtrade.Recipes.RecipeReagent do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wowtrade.Recipes.Recipe
  alias Wowtrade.Items.Item

  schema "recipes_reagents" do
    belongs_to :recipe, Recipe
    belongs_to :reagent, Item, references: :item_id, foreign_key: :item_id
    field :amount, :integer
  end

  # @doc false
  def changeset(recipe_reagent, attrs) do
    recipe_reagent
    |> cast(attrs, [:amount, :recipe_id, :item_id])
    |> unique_constraint([:item_id, :recipe_id])
  end
end
