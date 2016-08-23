cog jit support
functionPointerForCompiledMethod: methodObj primitiveIndex: primIndex
	<api>
	<returnTypeC: 'void (*functionPointerForCompiledMethodprimitiveIndex(sqInt methodObj, sqInt primIndex))(void)'>
	| functionPointer |
	<var: #functionPointer declareC: #'void (*functionPointer)(void)'>
	functionPointer := self functionPointerFor: primIndex inClass: nil.
	functionPointer == #primitiveCalloutToFFI ifTrue:
		[^self functionForPrimitiveCallout].
	functionPointer == #primitiveExternalCall ifTrue:
		[^self functionForPrimitiveExternalCall: methodObj].
	^functionPointer