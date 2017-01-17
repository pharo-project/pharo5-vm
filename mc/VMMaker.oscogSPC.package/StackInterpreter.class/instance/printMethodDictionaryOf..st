debug printing
printMethodDictionaryOf: behavior
	<api>
	self printMethodDictionary: (objectMemory fetchPointer: MethodDictionaryIndex ofObject: behavior)