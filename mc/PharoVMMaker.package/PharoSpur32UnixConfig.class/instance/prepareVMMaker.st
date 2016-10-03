source generation
prepareVMMaker
	| maker |
	maker := super prepareVMMaker.
	maker options: #(
		ObjectMemory Spur32BitCoMemoryManager
		MULTIPLEBYTECODESETS true 
		bytecodeTableInitializer initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid
		ISA IA32).
	^ maker