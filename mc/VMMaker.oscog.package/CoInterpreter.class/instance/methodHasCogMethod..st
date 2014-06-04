compiled methods
methodHasCogMethod: aMethodOop
	<api>
	self assert: (objectMemory isNonImmediate: aMethodOop).
	^self isCogMethodReference: (self rawHeaderOf: aMethodOop)