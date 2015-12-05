primitive generators
genPrimitiveNew
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveNew: (self primRetNOffsetFor: 0))