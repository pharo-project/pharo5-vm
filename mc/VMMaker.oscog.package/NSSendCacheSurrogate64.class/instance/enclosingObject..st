accessing
enclosingObject: aValue
	^memory
		unsignedLongLongAt: address + 25
		put: aValue