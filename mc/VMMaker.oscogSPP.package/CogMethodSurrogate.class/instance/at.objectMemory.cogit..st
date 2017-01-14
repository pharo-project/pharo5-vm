instance initialization
at: anAddress objectMemory: objectMemory cogit: aCogit
	address := anAddress.
	memory := objectMemory memory.
	baseHeaderSize := objectMemory baseHeaderSize.
	cogit := aCogit