bytecode generators
genCallPrimitiveBytecode
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	"This makes sense only for the optimizing JITs"
	^EncounteredUnknownBytecode