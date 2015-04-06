accessing
depth: aValue
	^memory
		unsignedLongAt: address + 21
		put: aValue