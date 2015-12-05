primitive generators
genPrimitiveObjectAt
	| savedIndex r |
	savedIndex := opcodeIndex.
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	r := objectRepresentation genInnerPrimitiveObjectAt: (self primRetNOffsetFor: 1).
	"If primitive is unimplemented, discard arg load."
	r = UnimplementedPrimitive ifTrue:
		[opcodeIndex := savedIndex].
	^self compileFallbackToInterpreterPrimitive: r