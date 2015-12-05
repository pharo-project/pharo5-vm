primitive generators
genPrimitiveNewMethod
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveNewMethod: 0)