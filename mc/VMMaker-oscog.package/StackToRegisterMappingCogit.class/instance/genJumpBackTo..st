bytecode generators
genJumpBackTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	^super genJumpBackTo: targetBytecodePC