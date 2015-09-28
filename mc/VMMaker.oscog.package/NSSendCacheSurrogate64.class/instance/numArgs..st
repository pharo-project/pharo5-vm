accessing
numArgs: aValue
	^memory
		long64At: address + 33
		put: aValue