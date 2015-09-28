accessing
selector: aValue
	^memory
		long64At: address + 25
		put: aValue