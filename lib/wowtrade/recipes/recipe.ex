defmodule Wowtrade.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wowtrade.Items.Item
  alias Wowtrade.Recipes.RecipeReagent

  schema "recipes" do
    field :category, :string
    belongs_to :item, Item, foreign_key: :item_id, references: :item_id
    field :max_amount, :integer
    field :min_amount, :integer
    field :required_skill, :integer
    has_many :recipe_reagents, RecipeReagent
    many_to_many :reagents, Item, join_through: "recipes_reagents"
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:item_id, :min_amount, :max_amount, :required_skill, :category])
    |> validate_required([:item_id, :min_amount, :max_amount, :required_skill, :category])
    |> cast_assoc(:recipe_reagents)
    |> unique_constraint([:item_id])
  end
end
