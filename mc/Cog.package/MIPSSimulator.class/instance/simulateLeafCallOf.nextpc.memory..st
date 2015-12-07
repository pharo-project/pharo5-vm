processor api
simulateLeafCallOf: address nextpc: nextpc memory: aMemory
	self unsignedRegister: RA put: nextpc.
	pc := address.