*Cog-method prototypes
InstructionStreamPROTOTYPEnextPc: currentByte
	"Answer the pc of the next bytecode following the current one, given the current bytecode.."

	^pc + (self method encoderClass bytecodeSize: currentByte)