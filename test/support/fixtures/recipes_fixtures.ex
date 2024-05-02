defmodule Wowtrade.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wowtrade.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        category: "some category",
        item_id: 42,
        max_amount: 42,
        min_amount: 42,
        required_skill: 42
      })
      |> Wowtrade.Recipes.create_recipe()

    recipe
  end
end
