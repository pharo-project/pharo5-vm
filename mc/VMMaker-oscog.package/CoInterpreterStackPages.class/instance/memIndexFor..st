page access
memIndexFor: byteAddress
	^(self oopForPointer: byteAddress) - coInterpreter stackZoneBase - 1 // BytesPerWord + 1