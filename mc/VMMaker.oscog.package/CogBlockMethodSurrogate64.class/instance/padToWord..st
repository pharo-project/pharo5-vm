accessing
padToWord: aValue
	^memory
		unsignedLongLongAt: address + 5
		put: aValue