source generation
prepareVMMaker
	| maker |
	maker := super prepareVMMaker.
	maker options: #(
		ObjectMemory Spur64BitCoMemoryManager
		MULTIPLEBYTECODESETS true
		bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid		
		ISA X64).
	^ maker