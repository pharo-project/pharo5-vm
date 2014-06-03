compiled methods
argumentCountOf: methodPointer
	<api>
	^self argumentCountOfMethodHeader: (self headerOf: methodPointer)