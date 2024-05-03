defmodule WowtradeWeb.ItemLive.RecipeComponent do
  use WowtradeWeb, :live_component

  alias Wowtrade.Recipes

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(:recipe, Recipes.get_recipe!(assigns.recipe.id))
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="ml-6 space-y-4">
      <%= for reagent <- @recipe.recipe_reagents do %>
        <li class="text-lg">
          <%= reagent.amount %>x
          <.link class="underline" navigate={"https://www.wowhead.com/wotlk/item=#{reagent.item.item_id}"}>
            <%= reagent.item.name %>
          </.link>

          <input type="text" class="ml-4 border-b border-neutral-500 bg-neutral-900 h-6 w-16" />
        </li>

        <%= for recipe <- reagent.item.recipes do %>
          <.live_component
            module={WowtradeWeb.ItemLive.RecipeComponent}
            id={"recipe-#{recipe.id}"}
            recipe={recipe}
          />
        <% end %>
      <% end %>
    </div>
    """
  end
end
