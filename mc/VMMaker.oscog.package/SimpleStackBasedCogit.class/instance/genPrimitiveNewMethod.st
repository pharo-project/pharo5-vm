primitive generators
genPrimitiveNewMethod
	| savedIndex r |
	savedIndex := opcodeIndex.
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	((r := objectRepresentation genInnerPrimitiveNewMethod: (self primRetNOffsetFor: 2)) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	"If primitive is unimplemented, discard arg load."
	r = UnimplementedPrimitive ifTrue:
		[opcodeIndex := savedIndex].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive