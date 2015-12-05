primitive generators
genPrimitiveAt
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveAt: (self primRetNOffsetFor: 1))