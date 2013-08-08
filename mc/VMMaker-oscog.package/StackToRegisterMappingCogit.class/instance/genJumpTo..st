bytecode generators
genJumpTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	^super genJumpTo: targetBytecodePC