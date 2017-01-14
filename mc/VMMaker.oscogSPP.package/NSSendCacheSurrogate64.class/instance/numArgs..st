accessing
numArgs: aValue
	^memory
		unsignedLong64At: address + 33
		put: aValue