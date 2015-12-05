primitive generators
genPrimitiveObjectAt
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveObjectAt: 0)