rump c stack
printRumpCStackTo: address
	self assert: (self isOnRumpCStack: address).
	heapBase - BytesPerWord
		to: address
		by: BytesPerWord negated
		do:
			[:addr|
			self printHex: addr; tab; printHex: (self longAt: addr); cr]