defmodule Wowtrade.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :category, :string
    field :item_id, :integer
    field :max_amount, :integer
    field :min_amount, :integer
    field :required_skill, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:item_id, :min_amount, :max_amount, :required_skill, :category])
    |> validate_required([:item_id, :min_amount, :max_amount, :required_skill, :category])
  end
end
