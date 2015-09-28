accessing
depth: aValue
	^memory
		long64At: address + 41
		put: aValue