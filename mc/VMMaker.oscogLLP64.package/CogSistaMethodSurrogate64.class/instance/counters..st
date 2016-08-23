accessing
counters: aValue
	^memory
		long64At: address + 33 + baseHeaderSize
		put: aValue