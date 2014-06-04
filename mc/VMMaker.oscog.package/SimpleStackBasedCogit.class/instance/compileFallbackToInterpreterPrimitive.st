primitive generators
compileFallbackToInterpreterPrimitive
	<inline: false>
	^self compileInterpreterPrimitive: (coInterpreter
											functionPointerForCompiledMethod: methodObj
											primitiveIndex: primitiveIndex)