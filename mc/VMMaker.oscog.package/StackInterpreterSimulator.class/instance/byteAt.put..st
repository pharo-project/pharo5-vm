memory access
byteAt: byteAddress put: byte
	self deprecated.
	^objectMemory byteAt: byteAddress put: byte