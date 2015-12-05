primitive generators
compileFallbackToInterpreterPrimitive: code
	<inline: false>
	(code < 0 and: [code ~= UnimplementedPrimitive]) ifTrue: "Generator failed, so no point continuing..."
		[^code].
	code = UnfailingPrimitive ifTrue:
		[^0].
	(code = CompletePrimitive
	 and: [(self methodUsesPrimitiveErrorCode) not]) ifTrue:
		[^0].
	^self compileInterpreterPrimitive: (coInterpreter
											functionPointerForCompiledMethod: methodObj
											primitiveIndex: primitiveIndex)