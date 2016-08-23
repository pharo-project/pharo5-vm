bytecode generator support
genJumpTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	deadCode := true. "can't fall through"
	^super genJumpTo: targetBytecodePC