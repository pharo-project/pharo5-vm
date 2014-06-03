accessing
methodObject: aValue
	^memory
		unsignedLongLongAt: address + baseHeaderSize + 9
		put: aValue