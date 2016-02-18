bytecode generator support
genJumpTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	^super genJumpTo: targetBytecodePC