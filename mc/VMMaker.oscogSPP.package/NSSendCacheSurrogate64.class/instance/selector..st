accessing
selector: aValue
	^memory
		unsignedLong64At: address + 25
		put: aValue