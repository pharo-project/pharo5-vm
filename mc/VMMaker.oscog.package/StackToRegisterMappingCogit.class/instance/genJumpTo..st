bytecode generator support
genJumpTo: targetBytecodePC
	self ssFlushTo: simStackPtr.
	deadCode := true. "can't fall through"
	self Jump: (self ensureFixupAt: (self eventualTargetOf: targetBytecodePC)).
	^0