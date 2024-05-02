defmodule Wowtrade.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wowtrade.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        class: "some class",
        content_phase: 42,
        item_id: 42,
        item_level: 42,
        item_link: "some item_link",
        name: "some name",
        quality: "some quality",
        required_level: 42,
        sell_price: 42,
        slot: "some slot",
        subclass: "some subclass",
        tooltip: "some tooltip",
        unique_name: "some unique_name",
        vendor_price: 42
      })
      |> Wowtrade.Items.create_item()

    item
  end
end
