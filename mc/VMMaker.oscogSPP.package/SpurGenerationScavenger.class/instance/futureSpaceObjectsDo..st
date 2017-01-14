debug support
futureSpaceObjectsDo: aBlock
	| obj |
	futureSurvivorStart > futureSpace start ifTrue:
		[obj := manager objectStartingAt: futureSpace start.
		 [obj < futureSurvivorStart] whileTrue:
			[aBlock value: obj.
			 obj := manager objectAfter: obj limit: futureSurvivorStart]]