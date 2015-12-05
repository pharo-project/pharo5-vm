primitive generators
genPrimitiveCharacterValue
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveCharacterValue: (self primRetNOffsetFor: 0))