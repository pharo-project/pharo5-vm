accessing
padToWord: aValue
	^memory
		unsignedLong64At: address + 5
		put: aValue