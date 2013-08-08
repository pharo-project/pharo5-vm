class initialization
initialize
	"BochsIA32Alien initialize"
	PostBuildStackDelta := 0.
	OpcodeExceptionMap := Array new: 256 withAll: #handleExecutionPrimitiveFailureAt:in:readOnlyBelow:.
	OpcodeExceptionMap
		at: 1 + self basicNew callOpcode			put: #handleCallFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew jmpOpcode			put: #handleJmpFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew retOpcode			put: #handleRetFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew movALObOpcode	put: #handleMovALObFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew movObALOpcode	put: #handleMovObALFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew movGvEvOpcode	put: #handleMovGvEvFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew movEvGvOpcode	put: #handleMovEvGvFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew movGbEbOpcode	put: #handleMovGbEbFailureAt:in:readOnlyBelow:;
		at: 1 + self basicNew movEbGbOpcode	put: #handleMovEbGbFailureAt:in:readOnlyBelow: