primitive generators
genPrimitiveCharacterValue
	| r |
	(r := objectRepresentation genInnerPrimitiveCharacterValue: objectMemory wordSize) < 0 ifTrue:
		[^r].
	^r = UnfailingPrimitive
		ifTrue: [0]
		ifFalse: [self compileFallbackToInterpreterPrimitive]