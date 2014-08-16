compiled methods
argumentCountOf: methodPointer
	<api>
	^self argumentCountOfMethodHeader: (objectMemory methodHeaderOf: methodPointer)