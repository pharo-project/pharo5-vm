primitive generators
genPrimitiveNewWithArg
	| r |
	((r := objectRepresentation genInnerPrimitiveNewWithArg: (self primRetNOffsetFor: 1)) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive