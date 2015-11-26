class initialization
initialize
	"BochsIA32Alien initialize"
	| it |
	it := self basicNew.
	PostBuildStackDelta := 0.
	OpcodeExceptionMap := Array new: 256 withAll: #handleExecutionPrimitiveFailureAt:in:.
	OpcodeExceptionMap
		at: 1 + it callOpcode			put: #handleCallFailureAt:in:;
		at: 1 + it jmpOpcode			put: #handleJmpFailureAt:in:;
		at: 1 + it retOpcode			put: #handleRetFailureAt:in:;
		at: 1 + it movALObOpcode	put: #handleMovALObFailureAt:in:;
		at: 1 + it movAXOvOpcode	put: #handleMovAXOvFailureAt:in:;
		at: 1 + it movObALOpcode	put: #handleMovObALFailureAt:in:;
		at: 1 + it movOvAXOpcode	put: #handleMovOvAXFailureAt:in:;
		at: 1 + it movGvEvOpcode	put: #handleMovGvEvFailureAt:in:;
		at: 1 + it movEvGvOpcode	put: #handleMovEvGvFailureAt:in:;
		at: 1 + it movGbEbOpcode	put: #handleMovGbEbFailureAt:in:;
		at: 1 + it movEbGbOpcode	put: #handleMovEbGbFailureAt:in:.
	ExtendedOpcodeExceptionMap := Array new: 256 withAll: #handleExecutionPrimitiveFailureAt:in:.
	ExtendedOpcodeExceptionMap
		at: 1 + it movGvEbOpcode put: #handleMovGvEbFailureAt:in: