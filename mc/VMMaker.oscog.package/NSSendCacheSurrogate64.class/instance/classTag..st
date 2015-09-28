accessing
classTag: aValue
	^memory
		long64At: address + 1
		put: aValue