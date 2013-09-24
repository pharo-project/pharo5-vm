debug printing
printHeaderTypeOf: objOop
	coInterpreter print: ((self numSlotsOf: objOop) >= self numSlotsMask
							ifTrue: [' 8 byte header']
							ifFalse: [' 16 byte header'])