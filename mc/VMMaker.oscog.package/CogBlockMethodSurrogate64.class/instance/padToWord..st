accessing
padToWord: aValue
	^memory
		long64At: address + 5
		put: aValue