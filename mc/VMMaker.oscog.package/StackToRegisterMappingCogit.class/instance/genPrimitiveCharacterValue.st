primitive generators
genPrimitiveCharacterValue
	| r |
	(r := objectRepresentation genInnerPrimitiveCharacterValue: 0) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive