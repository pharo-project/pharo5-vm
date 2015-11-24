as yet unclassified
isJump
	^super isJump or: [opcode between: BrEqualRR and: BrLongNotEqualRR]