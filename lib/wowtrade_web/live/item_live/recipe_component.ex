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
      <div>
      <%= if elem(@total, 0) == :ok do %>
        <div>Total cost per item: <%= floor(elem(@total, 1) / ((@recipe.min_amount + @recipe.max_amount) / 2)) %></div>

        <%= if @price do %>
          <div>Profit per item: <%= floor(@price.price - (elem(@total, 1) / ((@recipe.min_amount + @recipe.max_amount) / 2))) %></div>
        <% end %>
      <% else %>
        <div><%= elem(@total, 1) %></div>
      <% end %>
      </div>

      <%= for reagent <- @recipe.recipe_reagents do %>
        <.live_component
          module={WowtradeWeb.ItemLive.ItemComponent}
          id={"item-#{@recipe.id}-#{reagent.id}-#{:rand.uniform(1000000)}"}
          reagent={reagent}
        />
      <% end %>
    </div>
    """
  end
end
