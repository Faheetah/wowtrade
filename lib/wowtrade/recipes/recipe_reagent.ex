defmodule Wowtrade.Recipes.RecipeReagent do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wowtrade.Recipes.Recipe
  alias Wowtrade.Items.Item

  schema "recipes_reagents" do
    belongs_to :recipe, Recipe
    belongs_to :item, Item
    field :amount, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(recipe_reagent, attrs) do
    recipe_reagent
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
