accessing
nextMethodOrIRCs: aValue
	^memory
		unsignedLong64At: address + baseHeaderSize + 33
		put: aValue