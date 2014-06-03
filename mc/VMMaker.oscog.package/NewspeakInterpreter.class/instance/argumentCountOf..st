compiled methods
argumentCountOf: methodPointer
	^ ((self headerOf: methodPointer) >> 25) bitAnd: 16r0F