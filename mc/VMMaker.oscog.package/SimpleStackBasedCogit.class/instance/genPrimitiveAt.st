primitive generators
genPrimitiveAt
	| r |
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	(r := objectRepresentation genInnerPrimitiveAt: (self primRetNOffsetFor: 1)) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive