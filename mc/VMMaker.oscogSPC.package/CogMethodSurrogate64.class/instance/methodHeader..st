accessing
methodHeader: aValue
	^memory
		unsignedLong64At: address + baseHeaderSize + 17
		put: aValue