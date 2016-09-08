generate machine code
padIfPossibleWithStopsFrom: startAddr to: endAddr
	startAddr to: endAddr - 1 by: 4 do: 
		[:addr | objectMemory longAt: addr put: self stop].