defmodule Wowtrade.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias Wowtrade.Repo

  alias Wowtrade.Items.Item
  alias Wowtrade.Items.Category

  @doc """
  Returns the list of items.
  """
  def list_items do
    Repo.all(Item)
    |> Repo.preload(:recipes)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.
  """
  def get_or_create_item!(item_id) do
    case get_item(item_id) do
      nil ->
        {parsed_item_id, _} = Integer.parse(item_id)
        Wowtrade.Sync.Blizzard.get_item(parsed_item_id)
        |> Repo.preload([recipes: [:item, :recipe_reagents]])

      item -> item
    end
  end

  def get_item(item_id) do
    Repo.get_by(Item, item_id: item_id)
    |> Repo.preload([recipes: [:item, :recipe_reagents]])
  end

  def get_items_for_category!(class, subclass) do
    Repo.all(from i in Item, where: i.class == ^class and i.subclass == ^subclass, order_by: [desc: i.item_level])
  end

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def list_categories do
    Repo.all(from c in Category, order_by: [asc: :class, asc: :subclass])
  end

  @doc """
  Creates a item.
  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end
end
