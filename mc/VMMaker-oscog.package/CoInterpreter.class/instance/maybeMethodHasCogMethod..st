compiled methods
maybeMethodHasCogMethod: anOop
	^(objectMemory isNonIntegerObject: anOop)
	  and: [(objectMemory isCompiledMethod: anOop)
	  and: [self isCogMethodReference: (self rawHeaderOf: anOop)]]