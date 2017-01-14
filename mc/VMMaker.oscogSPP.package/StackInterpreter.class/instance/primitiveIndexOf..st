compiled methods
primitiveIndexOf: methodPointer
	<api>
	^self primitiveIndexOfMethod: methodPointer header: (objectMemory methodHeaderOf: methodPointer)