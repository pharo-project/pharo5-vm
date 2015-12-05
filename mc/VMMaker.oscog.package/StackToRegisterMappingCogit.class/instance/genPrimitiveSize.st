primitive generators
genPrimitiveSize
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveSize: 0)