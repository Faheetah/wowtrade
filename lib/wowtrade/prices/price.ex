defmodule Wowtrade.Prices.Price do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prices" do
    field :auction_id, :integer
    field :item_id, :integer
    field :bid, :integer
    field :buyout, :integer
    field :quantity, :integer
    field :time_left, :string
    field :realm, :integer
    field :auction_house, :integer

    timestamps(type: :utc_datetime)
  end

  @fields [
    :auction_id,
    :item_id,
    :bid,
    :buyout,
    :quantity,
    :time_left,
    :realm,
    :auction_house
  ]

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
