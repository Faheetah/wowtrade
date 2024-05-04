defmodule WowtradeWeb.ItemLive.Categories do
  use WowtradeWeb, :live_view

  alias Wowtrade.Items
  alias Wowtrade.Items.Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :items, Items.list_items())}
  end

  @impl true
  def handle_params(%{"class" => class, "subclass" => subclass}, _url, socket) do
    items = Items.get_items_for_category!(class, subclass)
    {
      :noreply,
      assign(socket, :items, items)
    }
  end
end
