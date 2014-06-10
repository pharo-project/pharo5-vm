accessing
at: index
	^(index between: 1 and: (objectMemory byteLengthOf: oop))
		ifTrue: [objectMemory fetchByte: index - 1 ofObject: oop]
		ifFalse: [self errorSubscriptBounds: index]