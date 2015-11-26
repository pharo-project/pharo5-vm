processor api
simulateLeafCallOf: address nextpc: nextpc memory: aMemory
	self signedRegister: RA put: nextpc.
	pc := address.