bytecode generator support
genJumpBackTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	^super genJumpBackTo: targetBytecodePC