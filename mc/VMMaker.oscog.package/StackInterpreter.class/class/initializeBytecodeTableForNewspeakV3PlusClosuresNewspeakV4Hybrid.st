initialization
initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid
	"StackInterpreter initializeBytecodeTableForNewspeakV3PlusClosuresNewspeakV4Hybrid"

	| v3Table v4Table |
	self initializeBytecodeTableForNewspeakV4.
	v4Table := BytecodeTable.
	AltBytecodeEncoderClassName := BytecodeEncoderClassName.
	AltLongStoreBytecode := LongStoreBytecode.
	self initializeBytecodeTableForNewspeakV3PlusClosures.
	v3Table := BytecodeTable.
	BytecodeTable := v3Table, v4Table