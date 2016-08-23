compiled methods
tempCountOf: methodPointer
	<api>
	^self temporaryCountOfMethodHeader: (objectMemory methodHeaderOf: methodPointer)