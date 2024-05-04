defmodule WowtradeWeb.ItemLive.Index do
  use WowtradeWeb, :live_view

  alias Wowtrade.Items
  alias Wowtrade.Items.Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    categories = Items.list_categories()
    {
      :noreply,
      assign(socket, :categories, categories)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, socket}
  end
end
