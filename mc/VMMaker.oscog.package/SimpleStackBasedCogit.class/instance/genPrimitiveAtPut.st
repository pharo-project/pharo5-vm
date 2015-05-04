primitive generators
genPrimitiveAtPut
	| r |
	self genLoadArgAtDepth: 1 into: Arg0Reg.
	self genLoadArgAtDepth: 0 into: Arg1Reg.
	((r := objectRepresentation genInnerPrimitiveAtPut: (self primRetNOffsetFor: 2)) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive