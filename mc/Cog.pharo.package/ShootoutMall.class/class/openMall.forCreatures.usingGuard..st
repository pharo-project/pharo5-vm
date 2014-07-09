private
openMall: aMall forCreatures: creatures usingGuard: sema
   | processes |
   processes := creatures
            collect: [:aCreature |
               [aCreature visitMall: aMall.
               sema signal] newProcess].
   processes do:
         [:proc |
         proc priority: Processor userBackgroundPriority.
         proc resume]