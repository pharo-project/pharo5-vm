inline cacheing
opcodeAtAddress: mcpc
	^(objectMemory longAt: mcpc) >> 26
