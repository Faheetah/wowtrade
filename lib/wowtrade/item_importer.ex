defmodule Wowtrade.ItemImporter do
  alias Wowtrade.Items

  def import_items_from_file(file \\ "test_data.json") do
    file
    |> File.read!()
    |> Jason.decode!()
    |> import_items()
  end

  def import_items(items) do
    item_errors =
      Enum.map(items, fn item -> create_item(item) end)
      |> Enum.reject(&filter_result/1)

    recipe_errors =
      Enum.flat_map(items, fn item -> create_recipes(item) end)
      |> Enum.reject(&filter_result/1)

    item_errors ++ recipe_errors
  end

  defp filter_result(nil), do: true
  defp filter_result({:ok, _}), do: true
  defp filter_result({:error, v}), do: Keyword.get(v.errors, :item_id)
  defp filter_result(_), do: false

  defp create_item(item) do
    Items.create_category(%{
      class: item["class"],
      subclass: item["subclass"],
      class_lower: maybe_downcase(item["class"]),
      subclass_lower: maybe_downcase(item["subclass"])
    })

    Enum.into(item, %{}, fn {k, v} -> {Macro.underscore(k), v} end)
    |> Items.create_item()
  end

  defp maybe_downcase(nil), do: nil
  defp maybe_downcase(name), do: String.downcase(name)

  defp create_recipes(%{"itemId" => item_id, "createdBy" => recipes}) do
    Enum.map(recipes, fn r -> create_recipe(r, item_id) end)
  end
  defp create_recipes(_item), do: []

  defp create_recipe(recipe, item_id) do
    [min, max] = recipe["amount"]

    Wowtrade.Recipes.create_recipe(%{
      "item_id" => item_id,
      "category" => recipe["category"],
      "min_amount" => min,
      "max_amount" => max,
      "required_skill" => recipe["requiredSkill"],
      "recipe_reagents" => Enum.map(recipe["reagents"], &format_reagents/1)
    })
  end

  defp format_reagents(reagents) do
    %{
      "amount" => reagents["amount"],
      "item_id" => reagents["itemId"]
    }
  end
end
