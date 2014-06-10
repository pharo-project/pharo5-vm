primitive generators
genPrimitiveAtPut
	| r |
	((r := objectRepresentation genInnerPrimitiveAtPut: 0) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive