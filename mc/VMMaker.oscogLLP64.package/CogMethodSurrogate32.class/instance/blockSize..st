accessing
blockSize: aValue
	^memory
		unsignedShortAt: address + baseHeaderSize + 5
		put: aValue