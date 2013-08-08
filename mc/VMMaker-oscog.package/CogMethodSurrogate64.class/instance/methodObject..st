accessing
methodObject: aValue
	^memory
		unsignedLongLongAt: address + 17
		put: aValue