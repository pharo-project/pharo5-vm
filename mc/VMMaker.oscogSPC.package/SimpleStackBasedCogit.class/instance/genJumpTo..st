bytecode generator support
genJumpTo: targetBytecodePC
	self Jump: (self ensureFixupAt: targetBytecodePC - initialPC).
	^0