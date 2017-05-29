rump c stack
printRumpCStackTo: address
	self assert: (self isOnRumpCStack: address).
	heapBase - objectMemory wordSize
		to: address
		by: objectMemory wordSize negated
		do:
			[:addr|
			self printHex: addr.
			addr = cogit processor sp
				ifTrue: [self print: ' sp->']
				ifFalse:
					[addr = cogit processor fp
						ifTrue: [self print: ' fp->']
						ifFalse: [self tab]].
			self tab; printHex: (objectMemory longAt: addr); cr]