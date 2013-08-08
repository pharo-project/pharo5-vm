accessing
cmNumArgs: aValue
	^memory
		unsignedByteAt: address + 9
		put: aValue