object testing
isInFutureSpace: address
	^self
		oop: address
		isGreaterThanOrEqualTo: scavenger futureSpace start
		andLessThan: scavenger futureSurvivorStart