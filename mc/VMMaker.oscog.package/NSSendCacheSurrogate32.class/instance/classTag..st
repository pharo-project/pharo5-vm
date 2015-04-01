accessing
classTag: aValue
	^memory
		unsignedLongAt: address + 9
		put: aValue