page access
memIndexFor: byteAddress
	^(self oopForPointer: byteAddress) - coInterpreter stackZoneBase - 1 // objectMemory wordSize + 1