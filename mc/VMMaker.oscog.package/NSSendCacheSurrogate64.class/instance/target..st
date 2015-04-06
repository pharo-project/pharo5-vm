accessing
target: aValue
	^memory
		unsignedLongLongAt: address + 17
		put: aValue