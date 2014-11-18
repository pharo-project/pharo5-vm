primitive generators
genPrimitiveSize
	| r |
	(r := objectRepresentation genInnerPrimitiveSize: objectMemory wordSize) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive