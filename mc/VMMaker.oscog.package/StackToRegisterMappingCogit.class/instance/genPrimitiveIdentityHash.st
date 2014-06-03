primitive generators
genPrimitiveIdentityHash
	| r |
	(r := objectRepresentation genInnerPrimitiveIdentityHash: 0) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive