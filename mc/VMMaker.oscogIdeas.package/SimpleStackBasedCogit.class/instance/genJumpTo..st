bytecode generator support
genJumpTo: targetBytecodePC
	self Jump: (self ensureFixupAt: targetBytecodePC).
	^0