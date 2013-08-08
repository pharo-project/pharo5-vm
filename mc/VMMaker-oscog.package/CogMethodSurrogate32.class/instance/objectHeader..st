accessing
objectHeader: aValue
	^memory
		unsignedLongAt: address + 1
		put: aValue