method prototypes
BytecodeEncoderPROTOTYPEsizeCallPrimitive: primitiveIndex
	^self sizeOpcodeSelector: #genCallPrimitive: withArguments: {primitiveIndex}