defmodule Wowtrade.Sync.Wowhead do
  import SweetXml

  def get_recipe(item_id) when is_integer(item_id) do
    response = HTTPoison.get! "https://www.wowhead.com/cata/item=#{item_id}&xml"
    parse_recipe(response.body)
    |> Enum.map(fn r -> insert_recipe(item_id, r) end)
  end

  defp parse_recipe(xml_data) do
    parse(xml_data)
    |> xpath(
        ~x"/wowhead/item/createdBy//spell"l,
        spell: ~x"./@id"i,
        name: ~x"./@name",
        min: ~x"./@minCount"i,
        max: ~x"./@maxCount"i,
        reagents: [
          ~x"./reagent"l,
          item_id: ~x"./@id"i,
          name: ~x"./@name",
          amount: ~x"./@count"i
        ]
    )
  end

  defp insert_recipe(item_id, recipe) do
    Enum.each(recipe.reagents, &upsert_reagent/1)
    Wowtrade.Recipes.create_recipe(%{
      item_id: item_id,
      min_amount: recipe.min,
      max_amount: recipe.max,
      recipe_reagents: recipe.reagents
    })
  end

  defp upsert_reagent(reagent) do
    if Wowtrade.Items.get_item(reagent.item_id) == nil do
      Wowtrade.Sync.Blizzard.get_item(reagent.item_id)
    end
  end
end
