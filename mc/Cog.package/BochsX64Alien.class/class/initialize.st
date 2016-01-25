class initialization
initialize
	"BochsX64Alien initialize"
	| it |
	it := self basicNew.
	OpcodeExceptionMap := Array new: 256 withAll: #handleExecutionPrimitiveFailureAt:in:rex:.
	OpcodeExceptionMap
		at: 1 + it twoByteEscape				put: #handleTwoByteEscapeFailureAt:in:rex:;
		at: 1 + it operandSizeOverridePrefix	put: #handleOperandSizeOverridePrefixFailureAt:in:rex:;
		at: 1 + it callOpcode		put: #handleCallFailureAt:in:rex:;
		at: 1 + it jmpOpcode		put: #handleJmpFailureAt:in:rex:;
		at: 1 + it retOpcode		put: #handleRetFailureAt:in:rex:;
		at: 1 + it movALObOpcode	put: #handleMovALObFailureAt:in:rex:;
		at: 1 + it movAXOvOpcode	put: #handleMovAXOvFailureAt:in:rex:;
		at: 1 + it movObALOpcode	put: #handleMovObALFailureAt:in:rex:;
		at: 1 + it movOvAXOpcode	put: #handleMovOvAXFailureAt:in:rex:;
		at: 1 + it movGvEvOpcode	put: #handleMovGvEvFailureAt:in:rex:;
		at: 1 + it movEvGvOpcode	put: #handleMovEvGvFailureAt:in:rex:;
		at: 1 + it movGbEbOpcode	put: #handleMovGbEbFailureAt:in:rex:;
		at: 1 + it movEbGbOpcode	put: #handleMovEbGbFailureAt:in:rex:;
		at: 1 + 16rFE				put: #handleGroup4FailureAt:in:rex:; "Table A6 One-Byte and Two-Byte Opcode ModRM Extensions"
		at: 1 + 16rFF				put: #handleGroup5FailureAt:in:rex:. "Table A6 One-Byte and Two-Byte Opcode ModRM Extensions"
	ExtendedOpcodeExceptionMap := Array new: 256 withAll: #handleExecutionPrimitiveFailureAt:in:rex:.
	ExtendedOpcodeExceptionMap
		at: 1 + it movGvEbOpcode put: #handleMovGvEbFailureAt:in:rex: