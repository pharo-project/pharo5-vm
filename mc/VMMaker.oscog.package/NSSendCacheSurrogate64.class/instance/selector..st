accessing
selector: aValue
	^memory
		unsignedLongLongAt: address + 1
		put: aValue