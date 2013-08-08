execution
simulateLeafCallOf: address nextpc: nextpc memory: aMemory
	self pushWord: nextpc in: aMemory.
	self eip: address