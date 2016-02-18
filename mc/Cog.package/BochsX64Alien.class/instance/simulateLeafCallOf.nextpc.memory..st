execution
simulateLeafCallOf: address nextpc: nextpc memory: aMemory
	self pushWord: nextpc in: aMemory.
	self rip: address