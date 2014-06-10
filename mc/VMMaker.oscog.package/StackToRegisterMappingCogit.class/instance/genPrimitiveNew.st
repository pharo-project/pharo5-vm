primitive generators
genPrimitiveNew
	| r numArgs |
	NewspeakVM
		ifTrue:
			[numArgs := coInterpreter argumentCountOf: methodObj.
			 numArgs = 1 ifTrue:
				[((r := objectRepresentation genInnerPrimitiveMirrorNew: 0) < 0
				  and: [r ~= UnimplementedPrimitive]) ifTrue:
					[^r]].
			 numArgs = 0 ifTrue:
				[((r := objectRepresentation genInnerPrimitiveNew: 0) < 0
				  and: [r ~= UnimplementedPrimitive]) ifTrue:
					[^r]]]
		ifFalse:
			[((r := objectRepresentation genInnerPrimitiveNew: 0) < 0
			  and: [r ~= UnimplementedPrimitive]) ifTrue:
				[^r]].
	"Call the interpreter primitive either when the machine-code primitive
	 fails, or if the machine-code primitive is unimplemented."
	^self compileFallbackToInterpreterPrimitive