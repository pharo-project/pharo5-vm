cog jit support
functionPointerForCompiledMethod: methodObj primitiveIndex: primIndex
	^self mapFunctionToAddress: (super functionPointerForCompiledMethod: methodObj primitiveIndex: primIndex)