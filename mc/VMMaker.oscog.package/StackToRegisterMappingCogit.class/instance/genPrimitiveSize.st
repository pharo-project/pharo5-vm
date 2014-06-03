primitive generators
genPrimitiveSize
	| r |
	(r := objectRepresentation genInnerPrimitiveSize: 0) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive