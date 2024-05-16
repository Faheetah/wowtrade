defmodule WowtradeWeb.ItemLive.Index do
  use WowtradeWeb, :live_view

  alias Wowtrade.Items

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
end
