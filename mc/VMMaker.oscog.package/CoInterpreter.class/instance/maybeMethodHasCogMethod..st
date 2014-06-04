compiled methods
maybeMethodHasCogMethod: anOop
	^(objectMemory isNonImmediate: anOop)
	  and: [(objectMemory isCompiledMethod: anOop)
	  and: [self isCogMethodReference: (self rawHeaderOf: anOop)]]