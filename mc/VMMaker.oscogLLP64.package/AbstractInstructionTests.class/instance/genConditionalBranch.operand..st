generating machine code
genConditionalBranch: opcode operand: operandOne
	^self previousInstruction noteFollowingConditionalBranch: (self gen: opcode operand: operandOne)