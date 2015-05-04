primitive generators
genPrimitiveSize
	| r |
	(r := objectRepresentation genInnerPrimitiveSize: (self primRetNOffsetFor: 0)) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive