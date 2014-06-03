primitive generators
genPrimitiveNew
	| r |
	((r := objectRepresentation genInnerPrimitiveNew: BytesPerWord) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive