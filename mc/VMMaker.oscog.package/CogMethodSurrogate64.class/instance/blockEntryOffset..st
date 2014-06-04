accessing
blockEntryOffset: aValue
	^memory
		unsignedShortAt: address + baseHeaderSize + 7
		put: aValue