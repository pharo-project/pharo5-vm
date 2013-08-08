execution simulation
simulateLeafCallOf: address nextpc: nextpc memory: aMemory
	self lr: nextpc.
	self pc: address