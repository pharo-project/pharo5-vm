accessing
startpc: aValue
	^memory
		unsignedShortAt: address + 3
		put: aValue