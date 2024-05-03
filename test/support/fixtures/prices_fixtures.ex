defmodule Wowtrade.PricesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wowtrade.Prices` context.
  """

  @doc """
  Generate a price.
  """
  def price_fixture(attrs \\ %{}) do
    {:ok, price} =
      attrs
      |> Enum.into(%{
        price: 42
      })
      |> Wowtrade.Prices.create_price()

    price
  end
end
