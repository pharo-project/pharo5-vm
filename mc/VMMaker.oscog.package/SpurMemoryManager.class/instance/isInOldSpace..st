object testing
isInOldSpace: address
	<api>
	^self
		oop: address
		isGreaterThanOrEqualTo: oldSpaceStart
		andLessThan: endOfMemory