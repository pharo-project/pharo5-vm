primitive generators
genPrimitiveAt
	| r |
	self assert: self numRegArgs >= 1.
	(r := objectRepresentation genInnerPrimitiveAt: 0) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive