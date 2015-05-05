primitive generators
genPrimitiveStringAtPut
	| savedIndex r |
	savedIndex := opcodeIndex.
	self genLoadArgAtDepth: 1 into: Arg0Reg.
	self genLoadArgAtDepth: 0 into: Arg1Reg.
	((r := objectRepresentation genInnerPrimitiveStringAtPut: (self primRetNOffsetFor: 2)) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	"If primitive is unimplemented, discard arg load."
	r = UnimplementedPrimitive ifTrue:
		[opcodeIndex := savedIndex].
	^self compileFallbackToInterpreterPrimitive