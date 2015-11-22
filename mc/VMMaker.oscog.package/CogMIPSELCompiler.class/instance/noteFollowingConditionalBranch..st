abstract instructions
noteFollowingConditionalBranch: branch
	"Support for processors without condition codes, such as the MIPS.
	 Answer the branch opcode.  Modify the receiver and the branch to
	 implement a suitable conditional branch that doesn't depend on
	 condition codes being set by the receiver."
	<var: #branch type: #'AbstractInstruction *'>
	branch opcode caseOf: {
		[JumpOverflow]		-> [opcode := opcode caseOf: {
										[AddCqR]	-> [AddCheckOverflowCqR].
										[AddRR]		-> [AddCheckOverflowRR].
										[MulRR]		-> [MulCheckOverflowRR].
										[SubCqR]	-> [SubCheckOverflowCqR].
										[SubRR]		-> [SubCheckOverflowRR].
										}].
		[JumpNoOverflow]	-> [opcode := opcode caseOf: {
										[AddCqR]	-> [AddCheckOverflowCqR].
										[AddRR]		-> [AddCheckOverflowRR].
										[MulRR]		-> [MulCheckOverflowRR].
										[SubCqR]	-> [SubCheckOverflowCqR].
										[SubRR]		-> [SubCheckOverflowRR].
										}].
		"Ryan, I'm imagining that all the other cases go in here, such as collapsing CmpRR; JumpZero to Label; BrEqRR.
		 This is obviously not nearly complete."
		[JumpZero]			-> [opcode caseOf: {
									[CmpRR]	-> [branch setOpcode: BrEqRR andOperandsFrom: self.
													branch operands at: 3 put: (operands at: 1).
													opcode := Label].
								}].
		[JumpNonZero]		-> [opcode caseOf: {
									[CmpRR]	-> [branch setOpcode: BrNeRR andOperandsFrom: self.
													branch operands at: 3 put: (operands at: 1).
													opcode := Label].
								}].
		[JumpLongZero]		-> [opcode caseOf: {
									[CmpRR]	-> [branch setOpcode: BrNeRR andOperandsFrom: self.
													"skip the following long branch"
													branch operands at: 3 put: self jumpLongByteSize.
													opcode := JumpLong].
								}].
		[JumpLongNonZero]	-> [opcode caseOf: {
									[CmpRR]	-> [branch setOpcode: BrEqRR andOperandsFrom: self.
													"skip the following long branch"
													branch operands at: 3 put: self jumpLongByteSize.
													opcode := JumpLong].
								}].
		}
		"No otherwise for now to catch all cases"
		"otherwise: []".
	^branch