accessing
cmType
	^(memory unsignedByteAt: address + 6) bitAnd: 16r7