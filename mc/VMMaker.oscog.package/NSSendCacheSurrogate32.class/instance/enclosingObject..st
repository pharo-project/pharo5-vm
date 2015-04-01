accessing
enclosingObject: aValue
	^memory
		unsignedLongAt: address + 13
		put: aValue