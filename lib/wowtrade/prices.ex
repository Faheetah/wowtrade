defmodule Wowtrade.Prices do
  @moduledoc """
  The Prices context.
  """

  import Ecto.Query, warn: false
  alias Wowtrade.Repo

  alias Wowtrade.Prices.Price

  @doc """
  Returns the list of prices.

  ## Examples

      iex> list_prices()
      [%Price{}, ...]

  """
  def list_prices do
    Repo.all(Price)
  end

  @doc """
  Gets a single price.

  Raises `Ecto.NoResultsError` if the Price does not exist.

  ## Examples

      iex> get_price!(123)
      %Price{}

      iex> get_price!(456)
      ** (Ecto.NoResultsError)

  """
  def get_price!(id), do: Repo.get!(Price, id)

  def get_latest_price_for_item!(item_id) do
    Repo.one(from p in Price, where: p.item_id == ^item_id, order_by: [desc: p.inserted_at], limit: 1)
  end

  def get_prices_for_recipe!(recipe) do
    Enum.reduce(recipe.recipe_reagents, {:ok, 0}, fn reagent, {status, count} ->
      price = get_latest_price_for_item!(reagent.item_id)
      item = Repo.preload(reagent, :item)
      lowest = find_lowest_price(item, price)

      # this is getting so ugly but it is late in the day
      if lowest != nil && status == :ok do
        {:ok, count + (reagent.amount * lowest)}
      else
        if status == :ok do
          {:error, "Could not find a price for #{item.item.name}"}
        else
          {status, count}
        end
      end
    end)
  end

  defp find_lowest_price(nil, %{price: price}), do: price
  defp find_lowest_price(%{item: %{vendor_price: vendor_price}}, nil), do: vendor_price
  defp find_lowest_price(%{item: %{vendor_price: vendor_price}}, %{price: price}) when vendor_price < price , do: vendor_price
  defp find_lowest_price(%{item: %{vendor_price: vendor_price}}, %{price: price}), do: price
  defp find_lowest_price(_item, _price), do: nil

  @doc """
  Creates a price.

  ## Examples

      iex> create_price(%{field: value})
      {:ok, %Price{}}

      iex> create_price(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_price(attrs \\ %{}) do
    %Price{}
    |> Price.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a price.

  ## Examples

      iex> update_price(price, %{field: new_value})
      {:ok, %Price{}}

      iex> update_price(price, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_price(%Price{} = price, attrs) do
    price
    |> Price.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a price.

  ## Examples

      iex> delete_price(price)
      {:ok, %Price{}}

      iex> delete_price(price)
      {:error, %Ecto.Changeset{}}

  """
  def delete_price(%Price{} = price) do
    Repo.delete(price)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking price changes.

  ## Examples

      iex> change_price(price)
      %Ecto.Changeset{data: %Price{}}

  """
  def change_price(%Price{} = price, attrs \\ %{}) do
    Price.changeset(price, attrs)
  end
end
