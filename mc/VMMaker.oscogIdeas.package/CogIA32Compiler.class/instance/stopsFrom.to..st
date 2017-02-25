generate machine code
stopsFrom: startAddr to: endAddr
	startAddr to: endAddr do:
		[:addr | objectMemory byteAt: addr put: self stop]