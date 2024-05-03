defmodule Wowtrade.Prices.Price do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prices" do
    field :price, :integer
    field :item_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, [:price, :item_id])
    |> validate_required([:price, :item_id])
  end
end
