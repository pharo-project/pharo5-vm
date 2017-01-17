accessing
selector: aValue
	^memory
		unsignedLong64At: address + baseHeaderSize + 25
		put: aValue