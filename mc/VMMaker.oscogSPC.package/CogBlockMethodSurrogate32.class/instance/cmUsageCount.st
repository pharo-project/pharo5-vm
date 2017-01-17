accessing
cmUsageCount
	^((memory unsignedByteAt: address + 2 + baseHeaderSize) bitShift: -5) bitAnd: 16r7