primitive generators
genPrimitiveIdentityHash
	| r |
	(r := objectRepresentation genInnerPrimitiveIdentityHash: objectMemory wordSize) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive