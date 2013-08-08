generate machine code - concretize
padIfPossibleWithNopsFrom: startAddr to: endAddr
	| nullBytes |
	nullBytes := (endAddr - startAddr + 1) \\ 4.
	self nopsFrom: startAddr to: endAddr - nullBytes.
	endAddr - nullBytes + 1 to: endAddr 
		do: [ :p | objectMemory byteAt: p put: 16r0]