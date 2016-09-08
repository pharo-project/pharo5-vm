simulation processor access
simulateLeafReturnIn: aMemory
	<doNotGenerate>
	self assertCorrectProcessorOwnership.
	^processor simulateLeafReturnIn: aMemory