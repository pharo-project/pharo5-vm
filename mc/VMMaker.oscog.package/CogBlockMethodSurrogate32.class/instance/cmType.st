accessing
cmType
	^(memory unsignedByteAt: address + 2 + baseHeaderSize) bitAnd: 16r7