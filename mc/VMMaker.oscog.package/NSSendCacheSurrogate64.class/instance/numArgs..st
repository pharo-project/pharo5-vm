accessing
numArgs: aValue
	^memory
		unsignedLongLongAt: address + 9
		put: aValue