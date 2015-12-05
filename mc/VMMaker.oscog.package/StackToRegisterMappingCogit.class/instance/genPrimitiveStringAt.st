primitive generators
genPrimitiveStringAt
	self assert: self numRegArgs >= 1.
	^self compileFallbackToInterpreterPrimitive:
		(objectRepresentation genInnerPrimitiveStringAt: 0)