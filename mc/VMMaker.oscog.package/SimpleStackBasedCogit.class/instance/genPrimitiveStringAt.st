primitive generators
genPrimitiveStringAt
	| r |
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	(r := objectRepresentation genInnerPrimitiveStringAt: (self primRetNOffsetFor: 1)) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive