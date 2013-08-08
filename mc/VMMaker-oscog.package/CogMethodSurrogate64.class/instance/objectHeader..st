accessing
objectHeader: aValue
	^memory
		unsignedLongLongAt: address + 1
		put: aValue