accessing
depth: aValue
	^memory
		unsignedLongLongAt: address + 41
		put: aValue