primitive generators
genPrimitiveSize
	| r |
	(r := objectRepresentation genInnerPrimitiveSize: BytesPerWord) < 0 ifTrue:
		[^r].
	^self compileInterpreterPrimitive: (coInterpreter
											functionPointerForCompiledMethod: methodObj
											primitiveIndex: primitiveIndex)