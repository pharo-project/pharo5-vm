accessing
selector: aValue
	^memory
		unsignedLongLongAt: address + baseHeaderSize + 25
		put: aValue