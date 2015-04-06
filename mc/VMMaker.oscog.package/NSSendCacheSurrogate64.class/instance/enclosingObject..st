accessing
enclosingObject: aValue
	^memory
		unsignedLongLongAt: address + 9
		put: aValue