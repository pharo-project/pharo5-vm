compiled methods
primitiveIndexOf: methodPointer
	<api>
	^self primitiveIndexOfMethod: methodPointer header: (self headerOf: methodPointer)