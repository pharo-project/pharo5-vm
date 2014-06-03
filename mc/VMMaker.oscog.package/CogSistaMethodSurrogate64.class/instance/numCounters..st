accessing
numCounters: aValue
	^memory
		unsignedLongLongAt: address + 41
		put: aValue