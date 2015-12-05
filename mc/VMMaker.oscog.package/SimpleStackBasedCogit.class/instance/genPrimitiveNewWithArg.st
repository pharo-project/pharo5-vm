primitive generators
genPrimitiveNewWithArg
	| savedIndex r |
	savedIndex := opcodeIndex.
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	r := objectRepresentation genInnerPrimitiveNewWithArg: (self primRetNOffsetFor: 1).
	"If primitive is unimplemented, discard arg load."
	r = UnimplementedPrimitive ifTrue:
		[opcodeIndex := savedIndex].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive: r