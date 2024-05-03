defmodule WowtradeWeb.ItemLive.Show do
  use WowtradeWeb, :live_view

  alias Wowtrade.Items

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:item, Items.get_item!(id))}
  end
end
