primitive generators
genPrimitiveIdentityHash
	| r |
	(r := objectRepresentation genInnerPrimitiveIdentityHash: BytesPerWord) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive