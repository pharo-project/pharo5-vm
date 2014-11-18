float primitives
fetchFloatAt: floatBitsAddress into: aFloat
	aFloat at: 1 put: (self long64At: floatBitsAddress)