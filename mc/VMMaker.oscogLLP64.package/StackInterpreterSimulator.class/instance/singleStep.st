testing
singleStep
	self assertValidExecutionPointers.
	atEachStepBlock value. "N.B. may be nil"
	self dispatchOn: currentBytecode in: BytecodeTable.
	self incrementByteCount