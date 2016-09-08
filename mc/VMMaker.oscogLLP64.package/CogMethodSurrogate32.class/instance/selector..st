accessing
selector: aValue
	^memory
		unsignedLongAt: address + baseHeaderSize + 17
		put: aValue