accessing
blockSize: aValue
	^memory
		unsignedShortAt: address + 9
		put: aValue