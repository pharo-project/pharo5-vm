generate machine code
padIfPossibleWithStopsFrom: startAddr to: endAddr
	| nullBytes |
	nullBytes := (endAddr - startAddr + 1) \\ 4.
	self stopsFrom: startAddr to: endAddr - nullBytes.
	endAddr - nullBytes + 1 to: endAddr 
		do: [ :p | objectMemory byteAt: p put: 16rFF]