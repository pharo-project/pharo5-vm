accessing
counters: aValue
	^memory
		unsignedLongLongAt: address + 33 + baseHeaderSize
		put: aValue