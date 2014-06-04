accessing
methodHeader: aValue
	^memory
		unsignedLongLongAt: address + baseHeaderSize + 17
		put: aValue