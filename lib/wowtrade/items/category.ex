defmodule Wowtrade.Items.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :class, :string
    field :class_lower, :string
    field :subclass, :string
    field :subclass_lower, :string
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:class, :subclass, :class_lower, :subclass_lower])
    |> validate_required([:class, :subclass, :class_lower, :subclass_lower])
    |> unique_constraint([:class, :subclass])
  end
end
