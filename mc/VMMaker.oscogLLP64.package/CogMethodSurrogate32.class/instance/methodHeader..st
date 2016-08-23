accessing
methodHeader: aValue
	^memory
		unsignedLongAt: address + baseHeaderSize + 13
		put: aValue