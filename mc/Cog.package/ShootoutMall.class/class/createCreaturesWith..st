initialize-release
createCreaturesWith: aCollectionOfColours
   "Private"

   | aName |
   aName := 0.
   ^aCollectionOfColours collect:
         [:aColour |
         aName := aName + 1.
         ShootoutCreature withName: aName colour: aColour]