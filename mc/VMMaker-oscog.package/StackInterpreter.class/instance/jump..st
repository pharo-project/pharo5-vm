jump bytecodes
jump: offset
	localIP := localIP + offset + 1.
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [currentBytecode := (objectMemory byteAtPointer: localIP) + bytecodeSetSelector]
		ifFalse: [currentBytecode := objectMemory byteAtPointer: localIP]