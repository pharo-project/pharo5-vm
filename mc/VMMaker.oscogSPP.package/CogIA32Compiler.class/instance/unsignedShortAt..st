accessing
unsignedShortAt: byteAddress
	^(objectMemory byteAt: byteAddress) + ((objectMemory byteAt: byteAddress + 1) bitShift: 8)