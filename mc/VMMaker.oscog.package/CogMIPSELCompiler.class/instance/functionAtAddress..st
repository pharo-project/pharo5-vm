inline cacheing
functionAtAddress: mcpc
	^(objectMemory longAt: mcpc) bitAnd: 63
