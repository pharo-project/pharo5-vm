accessing
cmType
	^(memory unsignedByteAt: address + 10) bitAnd: 16r7