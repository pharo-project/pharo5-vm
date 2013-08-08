accessing
cmUsageCount
	^((memory unsignedByteAt: address + 6) bitShift: -5) bitAnd: 16r7