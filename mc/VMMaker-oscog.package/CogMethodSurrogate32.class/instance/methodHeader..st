accessing
methodHeader: aValue
	^memory
		unsignedLongAt: address + 17
		put: aValue