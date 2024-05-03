defmodule WowtradeWeb.ItemLive.RecipeComponent do
  use WowtradeWeb, :live_component

  alias Wowtrade.Recipes
  alias Wowtrade.Prices

  @impl true
  def update(assigns, socket) do
    recipe = Recipes.get_recipe!(assigns.recipe.id)
    {
      :ok,
      socket
      |> assign(:recipe, recipe)
      |> assign(:price, assigns.price)
      |> assign(:total, Prices.get_prices_for_recipe!(recipe))
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="ml-6 space-y-4">
      <%= if elem(@total, 0) == :ok do %>
        <div>Total Cost: <%= elem(@total, 1) %></div>

        <%= if @price do %>
          <div>Profit: <%= @price.price - elem(@total, 1) %></div>
        <% end %>
      <% else %>
        <div><%= elem(@total, 1) %></div>
      <% end %>

      <%= for reagent <- @recipe.recipe_reagents do %>
        <.live_component
          module={WowtradeWeb.ItemLive.ItemComponent}
          id={"item-#{reagent.item.id}"}
          reagent={reagent}
        />
      <% end %>
    </div>
    """
  end
end
