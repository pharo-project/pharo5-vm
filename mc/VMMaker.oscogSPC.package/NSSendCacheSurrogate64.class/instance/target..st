accessing
target: aValue
	^memory
		unsignedLong64At: address + 17
		put: aValue