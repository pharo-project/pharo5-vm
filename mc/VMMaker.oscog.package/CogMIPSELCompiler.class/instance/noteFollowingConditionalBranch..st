abstract instructions
noteFollowingConditionalBranch: branch
	"Support for processors without condition codes, such as the MIPS.
	 Answer the branch opcode.  Modify the receiver and the branch to
	 implement a suitable conditional branch that doesn't depend on
	 condition codes being set by the receiver."
	<returnTypeC: #'AbstractInstruction *'>
	<var: #branch type: #'AbstractInstruction *'>
	| newBranchLeft newBranchOpcode newBranchRight |
	
	((branch opcode = JumpOverflow) or: [branch opcode = JumpNoOverflow]) 
		ifTrue: [^self noteFollowingOverflowBranch: branch].

	newBranchOpcode := branch opcode caseOf: {
		[JumpZero] 			-> [BrEqualRR].
		[JumpNonZero]			-> [BrNotEqualRR].
		[JumpBelow]			-> [BrUnsignedLessRR].
		[JumpBelowOrEqual]	-> [BrUnsignedLessEqualRR].
		[JumpAbove]			-> [BrUnsignedGreaterRR].
		[JumpAboveOrEqual]	-> [BrUnsignedGreaterEqualRR].
		[JumpLess]				-> [BrSignedLessRR].
		[JumpLessOrEqual]		-> [BrSignedLessEqualRR].
		[JumpGreater]			-> [BrSignedGreaterRR].
		[JumpGreaterOrEqual]	-> [BrSignedGreaterEqualRR].
		[JumpLongZero] 		-> [BrLongEqualRR].
		[JumpLongNonZero]	-> [BrLongNotEqualRR].
		
		[JumpNegative]			-> [BrSignedLessRR].
	} otherwise: [self unreachable. 0].
	
	opcode caseOf: {
		[BrEqualRR]	->	["I.e., two jumps after a compare."
						newBranchLeft := operands at: 1.
						newBranchRight := operands at: 2].
		[BrUnsignedLessRR]	->	["I.e., two jumps after a compare."
						newBranchLeft := operands at: 1.
						newBranchRight := operands at: 2].

		[CmpRR] 	-> 	[newBranchLeft := operands at: 1.
						 newBranchRight := operands at: 0.
						 opcode := Label].
		[CmpCqR]	-> 	[newBranchLeft := operands at: 1.
						 newBranchRight := AT.
						 opcode := MoveCqR.
						 operands at: 1 put: AT].
		[CmpCwR]	-> 	[newBranchLeft := operands at: 1.
						 newBranchRight := AT.
						 opcode := MoveCwR.
						 operands at: 1 put: AT].
		[TstCqR]	->	[newBranchLeft := Cmp.
						 newBranchRight := ZR].
		[AndCqR]	->	[newBranchLeft := operands at: 1.
						 newBranchRight := ZR].
		[AndCqRR]	->	[newBranchLeft := operands at: 2.
						 newBranchRight := ZR].
		[OrRR]	->		[newBranchLeft := operands at: 1.
						 newBranchRight := ZR].
		[XorRR]	->		[newBranchLeft := operands at: 1.
						 newBranchRight := ZR].
		[SubCwR]	->	[newBranchLeft := operands at: 1.
						 newBranchRight := ZR].
		[SubCqR]	->	[newBranchLeft := operands at: 1.
						 newBranchRight := ZR].
		[ArithmeticShiftRightCqR]	->	[newBranchLeft := operands at: 1.
						 newBranchRight := ZR].
	} otherwise: [self unreachable].

	branch rewriteOpcode: newBranchOpcode with: newBranchLeft with: newBranchRight.
	^branch