object testing
isInOldSpace: address
	^self
		oop: address
		isGreaterThanOrEqualTo: oldSpaceStart
		andLessThan: endOfMemory