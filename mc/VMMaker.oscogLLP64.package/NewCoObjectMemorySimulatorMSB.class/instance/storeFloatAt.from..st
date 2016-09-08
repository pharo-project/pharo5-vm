float primitives
storeFloatAt: floatBitsAddress from: aFloat

	self long32At: floatBitsAddress put: (aFloat at: 1).
	self long32At: floatBitsAddress+4 put: (aFloat at: 2)