primitive generators
genPrimitiveCharacterValue
	| r |
	(r := objectRepresentation genInnerPrimitiveCharacterValue: (self primRetNOffsetFor: 0)) < 0 ifTrue:
		[^r].
	^r = UnfailingPrimitive
		ifTrue: [0]
		ifFalse: [self compileFallbackToInterpreterPrimitive]