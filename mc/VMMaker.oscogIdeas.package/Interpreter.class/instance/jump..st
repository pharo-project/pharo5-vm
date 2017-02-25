jump bytecodes
jump: offset

	localIP := localIP + offset + 1.
	currentBytecode := self byteAtPointer: localIP.
