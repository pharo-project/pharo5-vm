controlling
visitMall: mall

   [| partner |
   partner := mall visitWith: self.
   partner ifNotNil:
         [colour := colour complementaryColourFor: partner colour.
         self == partner ifTrue: [selfMet := selfMet + 1].
         creaturesMet := creaturesMet + 1].
   partner isNil]
         whileFalse