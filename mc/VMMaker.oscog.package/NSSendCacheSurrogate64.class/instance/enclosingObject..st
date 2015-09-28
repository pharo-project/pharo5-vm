accessing
enclosingObject: aValue
	^memory
		long64At: address + 9
		put: aValue