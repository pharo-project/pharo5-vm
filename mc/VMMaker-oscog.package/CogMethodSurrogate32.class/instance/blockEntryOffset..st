accessing
blockEntryOffset: aValue
	^memory
		unsignedShortAt: address + 11
		put: aValue