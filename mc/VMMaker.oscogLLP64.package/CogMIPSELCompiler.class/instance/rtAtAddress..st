inline cacheing
rtAtAddress: mcpc
	^(objectMemory longAt: mcpc) >> 16 bitAnd: 31
