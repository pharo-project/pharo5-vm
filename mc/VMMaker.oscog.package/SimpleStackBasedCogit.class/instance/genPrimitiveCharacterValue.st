primitive generators
genPrimitiveCharacterValue
	| r |
	(r := objectRepresentation genInnerPrimitiveCharacterValue: objectMemory wordSize) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive