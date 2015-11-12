generate machine code
nopsFrom: startAddr to: endAddr
	self assert: endAddr - startAddr + 1 \\ 4 = 0.
	self assert: (self nop = 0).
	startAddr to: endAddr do: [:p| objectMemory byteAt: p put: 0].