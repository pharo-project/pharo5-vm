primitive generators
genPrimitiveStringAtPut
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveStringAtPut: 0)