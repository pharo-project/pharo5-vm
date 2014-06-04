object testing
isInSurvivorSpace: address
	^self
		oop: address
		isGreaterThanOrEqualTo: scavenger pastSpace start
		andLessThan: pastSpaceStart