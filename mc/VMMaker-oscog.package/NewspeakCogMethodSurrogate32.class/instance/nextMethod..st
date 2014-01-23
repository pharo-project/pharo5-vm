accessing
nextMethod: aValue
	^memory
		unsignedLongAt: address + 25
		put: aValue