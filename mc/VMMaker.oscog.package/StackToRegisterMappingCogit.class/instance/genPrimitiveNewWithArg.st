primitive generators
genPrimitiveNewWithArg
	| r numArgs |
	NewspeakVM
		ifTrue:
			[r := 0.
			 numArgs := coInterpreter argumentCountOf: methodObj.
			 numArgs = 2 ifTrue:
				[r := objectRepresentation genInnerPrimitiveMirrorNewWithArg: 0].
			 numArgs = 1 ifTrue:
				[r := objectRepresentation genInnerPrimitiveNewWithArg: 0]]
		ifFalse:
			[r := objectRepresentation genInnerPrimitiveNewWithArg: 0].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive: r