defmodule Wowtrade.Sync.Blizzard do
  alias Wowtrade.Items
  alias Wowtrade.Prices

  def get_auctions() do
    get_auctions(4388, 2)
  end

  def get_auctions(realm_id, ah_id) when is_integer(realm_id) and is_integer(ah_id) do
    access_token = Application.get_env(:wowtrade, __MODULE__)[:access_token]

    if access_token != nil do
      %{status_code: 200, body: body} = HTTPoison.get! "https://us.api.blizzard.com/data/wow/connected-realm/#{realm_id}/auctions/#{ah_id}?namespace=dynamic-classic-us&locale=en_US&access_token=#{access_token}"

      Jason.decode!(body)
      |> Map.get("auctions")
      |> Enum.each(fn a -> process_auction(a, realm_id, ah_id) end)
    end
  end

  def process_auction(a, realm_id, ah_id) do
    {:ok, _price} = Prices.create_price(%{
      realm: realm_id,
      auction_house: ah_id,
      auction_id: a["id"],
      item_id: a["item"]["id"],
      bid: a["bid"],
      buyout: a["buyout"],
      quantity: a["quantity"],
      time_left: a["time_left"]
    })
  end

  def get_item(item_id) when is_integer(item_id) do
    do_item_request(item_id)
    |> insert_item
  end

  def do_item_request(item_id) do
    access_token = Application.get_env(:wowtrade, __MODULE__)[:access_token]

    if access_token != nil do
      %{status_code: 200, body: body} = HTTPoison.get! "https://us.api.blizzard.com/data/wow/item/#{item_id}?namespace=static-classic-us&locale=en_US&access_token=#{access_token}"
      Jason.decode!(body)
    end
  end

  defp insert_item(item) do
    %{"item_class" => %{"name" => item_class}} = item
    %{"item_subclass" => %{"name" => item_subclass}} = item

    Items.create_category(%{
      class: item_class,
      subclass: item_subclass,
      class_lower: maybe_downcase(item_class),
      subclass_lower: maybe_downcase(item_subclass),
    })

    {:ok, created_item} = Items.create_item(%{
      class: item_class,
      subclass: item_subclass,
      item_id: item["id"],
      item_level: item["level"],
      name: item["name"],
      quality: item["quality"]["name"],
      required_level: item["required_level"],
      sell_price: item["sell_price"],
      vendor_price: floor(item["purchase_price"] / item["purchase_quantity"])
    })

    Wowtrade.Sync.Wowhead.get_recipe(created_item.item_id)

    created_item
  end

  defp maybe_downcase(nil), do: nil
  defp maybe_downcase(name), do: String.downcase(name)
end
