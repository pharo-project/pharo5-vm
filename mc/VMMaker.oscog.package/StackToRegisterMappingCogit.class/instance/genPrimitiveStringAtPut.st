primitive generators
genPrimitiveStringAtPut
	| r |
	((r := objectRepresentation genInnerPrimitiveStringAtPut: 0) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive