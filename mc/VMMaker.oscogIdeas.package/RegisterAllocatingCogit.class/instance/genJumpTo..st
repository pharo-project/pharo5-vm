bytecode generator support
genJumpTo: targetBytecodePC
	"Overriden to avoid the flush because in this cogit stack state is merged at merge point."
	deadCode := true. "can't fall through"
	self Jump: (self ensureFixupAt: (self eventualTargetOf: targetBytecodePC)).
	^ 0