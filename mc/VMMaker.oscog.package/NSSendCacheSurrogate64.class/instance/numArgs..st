accessing
numArgs: aValue
	^memory
		unsignedLongLongAt: address + 33
		put: aValue