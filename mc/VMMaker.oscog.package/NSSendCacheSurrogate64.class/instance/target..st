accessing
target: aValue
	^memory
		long64At: address + 17
		put: aValue