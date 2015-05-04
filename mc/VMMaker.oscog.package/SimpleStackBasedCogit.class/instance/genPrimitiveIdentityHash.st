primitive generators
genPrimitiveIdentityHash
	| r |
	(r := objectRepresentation genInnerPrimitiveIdentityHash: (self primRetNOffsetFor: 0)) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive