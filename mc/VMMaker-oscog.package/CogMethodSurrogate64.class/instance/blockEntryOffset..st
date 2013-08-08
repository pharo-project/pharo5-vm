accessing
blockEntryOffset: aValue
	^memory
		unsignedShortAt: address + 15
		put: aValue