primitive generators
genPrimitiveSize
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveSize: (self primRetNOffsetFor: 0))