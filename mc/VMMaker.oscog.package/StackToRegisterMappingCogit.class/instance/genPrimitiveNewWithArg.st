primitive generators
genPrimitiveNewWithArg
	| r numArgs |
	NewspeakVM
		ifTrue:
			[numArgs := coInterpreter argumentCountOf: methodObj.
			 numArgs = 2 ifTrue:
				[((r := objectRepresentation genInnerPrimitiveMirrorNewWithArg: 0) < 0
				  and: [r ~= UnimplementedPrimitive]) ifTrue:
					[^r]].
			 numArgs = 1 ifTrue:
				[((r := objectRepresentation genInnerPrimitiveNewWithArg: 0) < 0
				  and: [r ~= UnimplementedPrimitive]) ifTrue:
					[^r]]]
		ifFalse:
			[((r := objectRepresentation genInnerPrimitiveNewWithArg: 0) < 0
			  and: [r ~= UnimplementedPrimitive]) ifTrue:
				[^r]].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive