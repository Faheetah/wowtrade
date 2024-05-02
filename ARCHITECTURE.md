# Game Data

Maybe this loads into mnesia repo so it is performant and because it is fixed size? Then warming the cache should be quick enough.

## Items

Load from wow-classic-items/data/json/data.json

Data structure from source:

itemId
name
icon
class - item classification
subclass - item subclassification
sellPrice - price if selling to vendor in copper
quality
itemLevel
requiredLevel
slot
createdBy (see recipe)
tooltip
itemLink
vendorPrice - cost from vendor in copper
contentPhase
source
uniqueName

For recipe:

amount - [min, max]
requiredSkill
category - the profession needed
reagents - [{itemId, amount}] ingredients
recipes - a list of recipes that train this

## ItemClasses

## Professions

Load from wow-classic-items/data/json/professions.json

## Recipes

Derive from Item import from wow-classic-items/data/json/data.json
Note that the recipe section is unreliable and item references only reference physical items that teach a recipe, and exclude trainers

### Recipes

General recipes

id - generated
item_id
min_amount
max_amount
required_skill
category

### RecipesReagents

Ingredients for a recipe

recipe_id
item_id
amount

### RecipesSources

Links a recipe to an item, can have multiple recipe sources

recipe_id
item_id

## ItemsRecipes

# Realm Data

SQL data for scalability

## Realms
era - always classic?

## Factions
1 alliance
2 horde

## ItemsPrices

# Analytics

Patterns to match (would be more accurate correlated if we can get user info)

* Price falls and volume rising sharply - undercutting happening
* Price falls slowly correlated with steadily decreasing volume - natural demand heavy
* Low quantity but falling price, volume stable - undercutting
* High volume to low volume, sharp price increase, low outliers from median - flipping
* High volume to low volume, steady price increase - natural supply heavy
* Low quantity steady volume regardless of price - infrequently bought item
