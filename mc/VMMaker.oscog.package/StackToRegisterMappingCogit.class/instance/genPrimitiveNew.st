primitive generators
genPrimitiveNew
	| r numArgs |
	NewspeakVM
		ifTrue:
			[r := 0.
			 numArgs := coInterpreter argumentCountOf: methodObj.
			 numArgs = 1 ifTrue:
				[r := objectRepresentation genInnerPrimitiveMirrorNew: 0].
			 numArgs = 0 ifTrue:
				[r := objectRepresentation genInnerPrimitiveNew: 0]]
		ifFalse:
			[r := objectRepresentation genInnerPrimitiveNew: 0].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive: r