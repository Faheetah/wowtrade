defmodule Wowtrade.Item.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :class, :string
    field :subclass, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:class, :subclass])
    |> validate_required([:class, :subclass])
  end
end
