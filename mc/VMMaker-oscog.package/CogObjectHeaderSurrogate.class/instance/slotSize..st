accessing
slotSize: aValue
	^memory
		unsignedByteAt: address + 8
		put: aValue