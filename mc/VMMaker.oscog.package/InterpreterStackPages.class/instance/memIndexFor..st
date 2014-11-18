page access
memIndexFor: byteAddress
	^(self oopForPointer: byteAddress) // objectMemory wordSize + indexOffset