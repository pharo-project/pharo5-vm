accessing
cmNumArgs: aValue
	^memory
		unsignedByteAt: address + baseHeaderSize + 1
		put: aValue