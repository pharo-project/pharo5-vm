primitive generators
genPrimitiveAtPut
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveAtPut: 0)