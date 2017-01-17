compile abstract instructions
genConditionalBranch: opcode operand: operandOne
	^self previousInstruction noteFollowingConditionalBranch: (self gen: opcode operand: operandOne)