primitive generators
genPrimitiveCharacterValue
	| r |
	(r := objectRepresentation genInnerPrimitiveCharacterValue: 0) < 0 ifTrue:
		[^r].
	^r = UnfailingPrimitive
		ifTrue: [0]
		ifFalse: [self compileFallbackToInterpreterPrimitive]