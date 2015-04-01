accessing
target: aValue
	^memory
		unsignedLongLongAt: address + 33
		put: aValue