accessing
methodHeader: aValue
	^memory
		long64At: address + baseHeaderSize + 17
		put: aValue