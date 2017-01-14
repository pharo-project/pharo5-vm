accessing
counters: aValue
	^memory
		unsignedLongAt: address + 21 + baseHeaderSize
		put: aValue