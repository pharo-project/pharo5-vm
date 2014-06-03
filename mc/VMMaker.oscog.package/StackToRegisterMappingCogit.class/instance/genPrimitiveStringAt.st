primitive generators
genPrimitiveStringAt
	| r |
	self assert: self numRegArgs >= 1.
	(r := objectRepresentation genInnerPrimitiveStringAt: 0) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive