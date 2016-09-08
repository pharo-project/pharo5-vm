compiled methods
argumentCountOf: methodPointer
	^((self methodHeaderOf: methodPointer) >> 25) bitAnd: 16r0F