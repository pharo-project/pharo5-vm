accessing
cmNumArgs: aValue
	^memory
		unsignedByteAt: address + 5
		put: aValue