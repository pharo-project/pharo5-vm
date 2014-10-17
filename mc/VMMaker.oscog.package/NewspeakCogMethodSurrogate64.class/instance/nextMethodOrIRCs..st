accessing
nextMethodOrIRCs: aValue
	^memory
		unsignedLongLongAt: address + baseHeaderSize + 33
		put: aValue