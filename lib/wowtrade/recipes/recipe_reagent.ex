defmodule Wowtrade.Recipes.RecipeReagent do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wowtrade.Recipes.Recipe
  alias Wowtrade.Items.Item

  schema "recipes_reagents" do
    belongs_to :recipe, Recipe
    belongs_to :item, Item, references: :item_id, foreign_key: :item_id
    field :amount, :integer
    field :spell_id, :integer
  end

  # @doc false
  def changeset(recipe_reagent, attrs) do
    recipe_reagent
    |> cast(attrs, [:amount, :recipe_id, :item_id, :spell_id])
    |> unique_constraint([:item_id, :spell_id])
    |> foreign_key_constraint(:item_id)
  end
end
