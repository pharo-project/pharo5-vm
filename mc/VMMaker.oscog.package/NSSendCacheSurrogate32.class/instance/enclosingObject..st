accessing
enclosingObject: aValue
	^memory
		unsignedLongAt: address + 5
		put: aValue