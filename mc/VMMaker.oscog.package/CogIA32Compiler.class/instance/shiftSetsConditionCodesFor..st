testing
shiftSetsConditionCodesFor: aConditionalJumpOpcode
	"OF flag only guaranteed to be set for 1-bit shifts.  See [1] p 490"
	^(opcode = ArithmeticShiftRightCqR or: [opcode = LogicalShiftLeftCqR])
	   and: [(operands at: 0) = 1]