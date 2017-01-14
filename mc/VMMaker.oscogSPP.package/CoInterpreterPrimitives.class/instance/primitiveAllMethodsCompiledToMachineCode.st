method introspection primitives
primitiveAllMethodsCompiledToMachineCode
	<export: true>
	<option: #SistaCogit>
	| arrayObj nEntries maxNumEntries |
	argumentCount ~= 0 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	maxNumEntries := cogit numMethods + objectMemory minSlotsForShortening.
	arrayObj := objectMemory 
		instantiateClass: (objectMemory splObj: ClassArray) 
		indexableSize: maxNumEntries.
	arrayObj ifNil: [^-1].
	nEntries := cogit methodsCompiledToMachineCodeInto: arrayObj.
	(nEntries < maxNumEntries) ifTrue:
		[objectMemory shorten: arrayObj toIndexableSize: nEntries].
	self pop: 1 thenPush: arrayObj