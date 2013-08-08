compiled methods
methodHasCogMethod: aMethodOop
	<api>
	self assert: (objectMemory isNonIntegerObject: aMethodOop).
	^self isCogMethodReference: (self rawHeaderOf: aMethodOop)