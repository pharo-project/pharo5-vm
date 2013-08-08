initialize-release
openMallWith: aCollectionOfColours forNumberOfMeets: aNumber
   | mall creatures guard |
   mall := self createAllowing: aNumber.
   mall run.
   creatures := self createCreaturesWith: aCollectionOfColours.
   guard := Semaphore new.
   self
      openMall: mall
      forCreatures: creatures
      usingGuard: guard.
   self
      waitForClosingOfMall: mall
      withCreatures: creatures
      usingGuard: guard.
   ^creatures