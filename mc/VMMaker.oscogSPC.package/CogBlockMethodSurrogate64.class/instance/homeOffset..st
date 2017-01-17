accessing
homeOffset: aValue
	^memory
		unsignedShortAt: address + 1
		put: aValue