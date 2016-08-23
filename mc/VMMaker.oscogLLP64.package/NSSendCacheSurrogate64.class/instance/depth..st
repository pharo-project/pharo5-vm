accessing
depth: aValue
	^memory
		unsignedLong64At: address + 41
		put: aValue