# Game Data

Maybe this loads into mnesia repo so it is performant and because it is fixed size? Then warming the cache should be quick enough.

## Items

Load from wow-classic-items/data/json/data.json

## Professions

Load from wow-classic-items/data/json/professions.json

## Recipes

Derive from Item import from wow-classic-items/data/json/data.json
Note that the recipe section is unreliable and item references only reference physical items that teach a recipe, and exclude trainers

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
