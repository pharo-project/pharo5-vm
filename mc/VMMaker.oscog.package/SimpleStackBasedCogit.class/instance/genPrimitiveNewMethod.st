primitive generators
genPrimitiveNewMethod
	| r |
	((r := objectRepresentation genInnerPrimitiveNewMethod: (self primRetNOffsetFor: 2)) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive