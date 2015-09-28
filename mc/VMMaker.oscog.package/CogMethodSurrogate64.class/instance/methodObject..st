accessing
methodObject: aValue
	^memory
		long64At: address + baseHeaderSize + 9
		put: aValue