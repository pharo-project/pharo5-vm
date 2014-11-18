rump c stack
printRumpCStackTo: address
	self assert: (self isOnRumpCStack: address).
	heapBase - objectMemory wordSize
		to: address
		by: objectMemory wordSize negated
		do:
			[:addr|
			self printHex: addr; tab; printHex: (self longAt: addr); cr]