compiled methods
tempCountOf: methodPointer
	^((self methodHeaderOf: methodPointer) >> 19) bitAnd: 16r3F