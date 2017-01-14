object testing
isInEden: objOop
	^self
		oop: objOop
		isGreaterThanOrEqualTo: scavenger eden start
		andLessThan: freeStart