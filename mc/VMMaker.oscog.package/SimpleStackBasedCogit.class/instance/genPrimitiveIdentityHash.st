primitive generators
genPrimitiveIdentityHash
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveIdentityHash: (self primRetNOffsetFor: 0))