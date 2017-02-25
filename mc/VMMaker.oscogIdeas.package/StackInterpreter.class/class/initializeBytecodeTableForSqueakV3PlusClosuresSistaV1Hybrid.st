initialization
initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid
	"StackInterpreter initializeBytecodeTableForSqueakV3PlusClosuresSistaV1Hybrid"

	| v3Table v1Table |
	self initializeBytecodeTableForSistaV1.
	v1Table := BytecodeTable.
	AltBytecodeEncoderClassName := BytecodeEncoderClassName.
	AltLongStoreBytecode := LongStoreBytecode.
	self initializeBytecodeTableForSqueakV3PlusClosures.
	BytecodeSetHasExtensions := true.
	v3Table := BytecodeTable.
	BytecodeTable := v3Table, v1Table