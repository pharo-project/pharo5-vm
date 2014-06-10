primitive generators
genPrimitiveCharacterValue
	| r |
	(r := objectRepresentation genInnerPrimitiveCharacterValue: BytesPerWord) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive