bytecode generators
genUnconditionalTrapBytecode
	"SistaV1: *	217		Trap"
	self ssFlushTo: simStackPtr.
	self CallRT: ceTrapTrampoline.
	self annotateBytecode: self Label.
	deadCode := true.
	^0