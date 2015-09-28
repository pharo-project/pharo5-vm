accessing
nextMethodOrIRCs: aValue
	^memory
		long64At: address + baseHeaderSize + 33
		put: aValue