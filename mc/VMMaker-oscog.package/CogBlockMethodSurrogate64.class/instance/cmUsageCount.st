accessing
cmUsageCount
	^((memory unsignedByteAt: address + 10) bitShift: -5) bitAnd: 16r7