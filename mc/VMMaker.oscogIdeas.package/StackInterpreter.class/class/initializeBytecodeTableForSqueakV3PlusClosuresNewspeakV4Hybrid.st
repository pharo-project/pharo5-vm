initialization
initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid
	"StackInterpreter initializeBytecodeTableForSqueakV3PlusClosuresNewspeakV4Hybrid"

	| v3Table v4Table |
	self initializeBytecodeTableForNewspeakV4.
	v4Table := BytecodeTable.
	AltBytecodeEncoderClassName := BytecodeEncoderClassName.
	AltLongStoreBytecode := LongStoreBytecode.
	self initializeBytecodeTableForSqueakV3PlusClosures.
	BytecodeSetHasExtensions := true.
	v3Table := BytecodeTable.
	BytecodeTable := v3Table, v4Table