bytecode generator support
genJumpBackTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	deadCode := true. "can't fall through"
	^super genJumpBackTo: targetBytecodePC