defmodule Wowtrade.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wowtrade.Recipes.Recipe

  schema "items" do
    field :class, :string
    field :content_phase, :integer
    field :item_id, :integer
    field :item_level, :integer
    field :item_link, :string
    field :name, :string
    field :quality, :string
    field :required_level, :integer
    field :sell_price, :integer
    field :slot, :string
    field :subclass, :string
    field :unique_name, :string
    field :vendor_price, :integer
    has_many :recipes, Recipe, foreign_key: :item_id, references: :item_id
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:item_id, :name, :class, :subclass, :sell_price, :quality, :item_level, :required_level, :slot, :item_link, :vendor_price, :content_phase, :unique_name])
    |> validate_required([:item_id, :name, :class, :item_link, :unique_name])
    |> unique_constraint([:item_id])
  end
end
