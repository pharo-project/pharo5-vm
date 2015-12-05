primitive generators
genPrimitiveAt
	self assert: self numRegArgs >= 1.
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveAt: 0)