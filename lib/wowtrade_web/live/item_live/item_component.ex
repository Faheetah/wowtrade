defmodule WowtradeWeb.ItemLive.ItemComponent do
  use WowtradeWeb, :live_component

  alias Wowtrade.Prices

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(:reagent, assigns.reagent)
      |> assign(:price, Prices.get_latest_price_for_item!(assigns.reagent.item.item_id))
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="ml-6 space-y-4">
      <li class="text-lg">
          <%= @reagent.amount %>x
          <.link class="underline" navigate={"https://www.wowhead.com/wotlk/item=#{@reagent.item.item_id}"}>
            <%= @reagent.item.name %>
          </.link>
          <%= if @reagent.item.vendor_price do %>
          <span class="text-neutral-400 ml-1"><.price price={@reagent.item.vendor_price} /></span>
          <% end %>

          <span>
            <form class="inline-block" phx-submit="update_price">
            <%= if @price do %>
              <input name="price" type="text" value={Map.get(@price, :buyout)} class="ml-4 border-b border-neutral-500 bg-neutral-900 h-5 w-24 text-xs" />
            <% else %>
              <input name="price" type="text" class="ml-4 border-b border-neutral-500 bg-neutral-900 h-5 w-24 text-xs" />
            <% end %>
            <input name="item_id" type="hidden" value={@reagent.item.item_id} />
            <button class="hover:text-green-400" type="submit">
              <.icon name="hero-check" />
            </button>
            </form>
          </span>
        </li>

        <%= for recipe <- @reagent.item.recipes do %>
          <%= if @reagent.item.subclass != "Elemental" do %>
            <.live_component
              module={WowtradeWeb.ItemLive.RecipeComponent}
              id={"recipe-#{recipe.id}-#{@reagent.id}"}
              recipe={recipe}
              price={@price}
            />
          <% end %>
        <% end %>
    </div>
    """
  end
end
