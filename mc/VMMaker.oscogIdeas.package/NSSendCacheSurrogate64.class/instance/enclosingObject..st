accessing
enclosingObject: aValue
	^memory
		unsignedLong64At: address + 9
		put: aValue