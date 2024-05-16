https://develop.battle.net/documentation/world-of-warcraft-classic/game-data-apis

https://develop.battle.net/access/clients/ to get API tokens

Cannot get recipes, would have to hit wowhead, but that also gives item info: https://www.wowhead.com/item=58087&xml

# Rate limiting

Bliz hands us 36,000/hr and 100/sec limits.

# Search Flow

Search is tokenized by name and matches how invert works

Check if search cache has an entry for a token, it drops plurals and posessives, which I am not sure if invert drops posessives.

Break search up into terms. Save the item link results for the terms.

* if we find a match for a term, grab the data for those results
* if we do not find a match for that term, add the term to the API search

After, grab everything that we have not fetched for a term from blizzard API. Iterate through each one's item ID on wowhead to get recipe data.

# Individual Item ID
