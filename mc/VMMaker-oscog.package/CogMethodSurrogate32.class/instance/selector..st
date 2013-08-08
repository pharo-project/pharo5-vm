accessing
selector: aValue
	^memory
		unsignedLongAt: address + 21
		put: aValue