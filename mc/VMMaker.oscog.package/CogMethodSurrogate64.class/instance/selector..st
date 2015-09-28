accessing
selector: aValue
	^memory
		long64At: address + baseHeaderSize + 25
		put: aValue