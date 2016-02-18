generate machine code
stopsFrom: startAddr to: endAddr
	self assert: endAddr - startAddr + 1 \\ 4 = 0.
	startAddr to: endAddr by: 4 do: 
		[:addr | objectMemory longAt: addr put: self stop].