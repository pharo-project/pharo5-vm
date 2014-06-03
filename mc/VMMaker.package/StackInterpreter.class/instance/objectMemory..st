initialization
objectMemory: anObjectMemory
	<doNotGenerate>
	objectMemory ifNotNil: [self halt].
	objectMemory := anObjectMemory