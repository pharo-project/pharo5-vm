compiled methods
tempCountOf: methodPointer
	^ ((self headerOf: methodPointer) >> 19) bitAnd: 16r3F