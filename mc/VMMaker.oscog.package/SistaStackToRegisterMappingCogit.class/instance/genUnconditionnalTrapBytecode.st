bytecode generators
genUnconditionnalTrapBytecode
	"SistaV1: *	217		Trap"
	"Use ssFlushNoUpdateTo: so we continue compiling as if the stack had not been flushed . 
	(typically, this kind of trap is in a branch)  
	Control does not return after the ceClassTrapTrampoline call."
	self ssFlushNoUpdateTo: simStackPtr.
	self CallRT: ceTrapTrampoline.
	^0