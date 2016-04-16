bytecode generator support
genJumpTo: targetBytecodePC
	self assert: simStackPtr <= (simSpillBase + 1). "Only 1 spilledValue max".
	"Self ssFlushTo: simStackPtr"
	self Jump: (self ensureFixupAt: targetBytecodePC - initialPC).
	^ 0