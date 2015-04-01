accessing
numArgs: aValue
	^memory
		unsignedLongAt: address + 5
		put: aValue