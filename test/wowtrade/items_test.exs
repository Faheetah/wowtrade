defmodule Wowtrade.ItemsTest do
  use Wowtrade.DataCase

  alias Wowtrade.Items

  describe "items" do
    alias Wowtrade.Items.Item

    import Wowtrade.ItemsFixtures

    @invalid_attrs %{class: nil, content_phase: nil, item_id: nil, item_level: nil, item_link: nil, name: nil, quality: nil, required_level: nil, sell_price: nil, slot: nil, subclass: nil, tooltip: nil, unique_name: nil, vendor_price: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{class: "some class", content_phase: 42, item_id: 42, item_level: 42, item_link: "some item_link", name: "some name", quality: "some quality", required_level: 42, sell_price: 42, slot: "some slot", subclass: "some subclass", tooltip: "some tooltip", unique_name: "some unique_name", vendor_price: 42}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.class == "some class"
      assert item.content_phase == 42
      assert item.item_id == 42
      assert item.item_level == 42
      assert item.item_link == "some item_link"
      assert item.name == "some name"
      assert item.quality == "some quality"
      assert item.required_level == 42
      assert item.sell_price == 42
      assert item.slot == "some slot"
      assert item.subclass == "some subclass"
      assert item.tooltip == "some tooltip"
      assert item.unique_name == "some unique_name"
      assert item.vendor_price == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{class: "some updated class", content_phase: 43, item_id: 43, item_level: 43, item_link: "some updated item_link", name: "some updated name", quality: "some updated quality", required_level: 43, sell_price: 43, slot: "some updated slot", subclass: "some updated subclass", tooltip: "some updated tooltip", unique_name: "some updated unique_name", vendor_price: 43}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.class == "some updated class"
      assert item.content_phase == 43
      assert item.item_id == 43
      assert item.item_level == 43
      assert item.item_link == "some updated item_link"
      assert item.name == "some updated name"
      assert item.quality == "some updated quality"
      assert item.required_level == 43
      assert item.sell_price == 43
      assert item.slot == "some updated slot"
      assert item.subclass == "some updated subclass"
      assert item.tooltip == "some updated tooltip"
      assert item.unique_name == "some updated unique_name"
      assert item.vendor_price == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
