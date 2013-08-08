accessing
blockSize: aValue
	^memory
		unsignedShortAt: address + 13
		put: aValue