testing
isJump
	^super isJump or: [opcode between: BrEqualRR and: BrLongNotEqualRR]