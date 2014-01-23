accessing
nextMethod: aValue
	^memory
		unsignedLongLongAt: address + 41
		put: aValue