primitive generators
genPrimitiveStringAt
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveStringAt: (self primRetNOffsetFor: 1))