testing
isBranch: anInstruction

	^ (anInstruction >> 24 bitAnd: 16r0E) = 16rA