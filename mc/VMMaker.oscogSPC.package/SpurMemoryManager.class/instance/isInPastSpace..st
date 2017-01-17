object testing
isInPastSpace: address
	^self
		oop: address
		isGreaterThanOrEqualTo: scavenger pastSpace start
		andLessThan: pastSpaceStart