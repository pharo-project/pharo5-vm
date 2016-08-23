accessing
classTag: aValue
	^memory
		unsignedLong64At: address + 1
		put: aValue