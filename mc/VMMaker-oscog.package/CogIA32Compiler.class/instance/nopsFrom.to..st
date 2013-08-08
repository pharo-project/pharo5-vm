generate machine code
nopsFrom: startAddr to: endAddr
	startAddr to: endAddr do:
		[:p| objectMemory byteAt: p put: 16r90]