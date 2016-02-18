accessing
methodObject: aValue
	^memory
		unsignedLong64At: address + baseHeaderSize + 9
		put: aValue