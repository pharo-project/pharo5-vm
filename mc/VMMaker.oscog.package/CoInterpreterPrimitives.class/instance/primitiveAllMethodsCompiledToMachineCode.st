method introspection primitives
primitiveAllMethodsCompiledToMachineCode
	<export: true>
	<option: #SistaCogit>
	| arrayObj |
	argumentCount ~= 0 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	arrayObj := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: cogit numMethods.
	arrayObj ifNil: [^-1].
	cogit methodsCompiledToMachineCodeInto: arrayObj.
	self pop: 1 thenPush: arrayObj