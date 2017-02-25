accessing
methodObject: aValue
	^memory
		unsignedLongAt: address + baseHeaderSize + 9
		put: aValue