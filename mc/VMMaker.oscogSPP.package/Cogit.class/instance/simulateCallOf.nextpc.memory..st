simulation processor access
simulateCallOf: address nextpc: nextpc memory: aMemory
	<doNotGenerate>
	self assertCorrectProcessorOwnership.
	^processor simulateCallOf: address nextpc: nextpc memory: aMemory