defmodule Wowtrade.RecipesTest do
  use Wowtrade.DataCase

  alias Wowtrade.Recipes

  describe "recipes" do
    alias Wowtrade.Recipes.Recipe

    import Wowtrade.RecipesFixtures

    @invalid_attrs %{category: nil, item_id: nil, max_amount: nil, min_amount: nil, required_skill: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{category: "some category", item_id: 42, max_amount: 42, min_amount: 42, required_skill: 42}

      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(valid_attrs)
      assert recipe.category == "some category"
      assert recipe.item_id == 42
      assert recipe.max_amount == 42
      assert recipe.min_amount == 42
      assert recipe.required_skill == 42
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      update_attrs = %{category: "some updated category", item_id: 43, max_amount: 43, min_amount: 43, required_skill: 43}

      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, update_attrs)
      assert recipe.category == "some updated category"
      assert recipe.item_id == 43
      assert recipe.max_amount == 43
      assert recipe.min_amount == 43
      assert recipe.required_skill == 43
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end
end
