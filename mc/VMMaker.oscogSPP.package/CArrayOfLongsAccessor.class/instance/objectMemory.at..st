initialize-release
objectMemory: anObjectMemory at: anAddress
	objectMemory := anObjectMemory.
	object := anObjectMemory memory.
	offset := anAddress / anObjectMemory wordSize.
	elementByteSize := anObjectMemory wordSize.
	address := anAddress