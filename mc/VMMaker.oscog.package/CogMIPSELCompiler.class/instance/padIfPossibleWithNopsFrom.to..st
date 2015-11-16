generate machine code
padIfPossibleWithNopsFrom: startAddr to: endAddr
	self flag: #bogus. "Methods should be initialized with the stop instruction, not nop."

	startAddr to: endAddr - 1 by: 4 do: 
		[:addr | objectMemory longAt: addr put: self stop].