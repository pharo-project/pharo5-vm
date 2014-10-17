class initialization
initialize
	"BochsIA32Alien initialize"
	PostBuildStackDelta := 0.
	OpcodeExceptionMap := Array new: 256 withAll: #handleExecutionPrimitiveFailureAt:in:.
	OpcodeExceptionMap
		at: 1 + self basicNew callOpcode			put: #handleCallFailureAt:in:;
		at: 1 + self basicNew jmpOpcode			put: #handleJmpFailureAt:in:;
		at: 1 + self basicNew retOpcode			put: #handleRetFailureAt:in:;
		at: 1 + self basicNew movALObOpcode	put: #handleMovALObFailureAt:in:;
		at: 1 + self basicNew movObALOpcode	put: #handleMovObALFailureAt:in:;
		at: 1 + self basicNew movGvEvOpcode	put: #handleMovGvEvFailureAt:in:;
		at: 1 + self basicNew movEvGvOpcode	put: #handleMovEvGvFailureAt:in:;
		at: 1 + self basicNew movGbEbOpcode	put: #handleMovGbEbFailureAt:in:;
		at: 1 + self basicNew movEbGbOpcode	put: #handleMovEbGbFailureAt:in: