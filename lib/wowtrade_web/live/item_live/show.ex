defmodule WowtradeWeb.ItemLive.Show do
  use WowtradeWeb, :live_view

  alias Wowtrade.Items
  alias Wowtrade.Prices

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
    }
  end

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(:price, Prices.get_latest_price_for_item!(assigns.item.item_id))
    }
  end

  @impl true
  def handle_event("update_price", %{"item_id" => item_id, "price" => price}, socket) do
    {:ok, _} = Prices.create_price(%{"item_id" => item_id, "price" => price})
    {:noreply, socket}
  end

  @impl true
  def handle_params(%{"id" => item_id}, _, socket) do
    {
      :noreply,
      socket
      |> assign(:item, Items.get_or_create_item!(item_id))
      |> assign(:price, Prices.get_latest_price_for_item!(item_id))
      |> assign(:prices, Prices.list_prices_for_item(item_id))
    }
  end
end
