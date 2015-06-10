testing
isPCDependent
	"Answer if the receiver is a pc-dependent instruction.  With out-of-line literals any instruction
	 that refers to a literal depends on the address of the literal, so add them in addition to the jumps."
	^self isJump or: [opcode = AlignmentNops or: [opcode = Call or: [dependent notNil and: [dependent opcode = Literal]]]]