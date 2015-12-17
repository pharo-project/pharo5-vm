abstract instructions
noteFollowingOverflowBranch: branch
	"Support for processors without condition codes, such as the MIPS.
	 Answer the branch opcode.  Modify the receiver and the branch to
	 implement a suitable conditional branch that doesn't depend on
	 condition codes being set by the receiver."
	<var: #branch type: #'AbstractInstruction *'>
	| newBranchOpcode |
	
	(opcode = MulRR) ifTrue:
		[opcode := MulCheckOverflowRR.
		 newBranchOpcode := branch opcode caseOf: {
			[JumpOverflow]		-> [BrNotEqualRR].
			[JumpNoOverflow]	-> [BrEqualRR].
		 } otherwise: [self unreachable. 0].
		 branch rewriteOpcode: newBranchOpcode with: OverflowTemp1 with: OverflowTemp2.
		 ^branch].


	opcode := opcode caseOf: {
		[AddCqR]	-> [AddCheckOverflowCqR].
		[AddRR]		-> [AddCheckOverflowRR].
		[SubCqR]	-> [SubCheckOverflowCqR].
		[SubRR]		-> [SubCheckOverflowRR].
	} otherwise: [self unreachable. 0].

	newBranchOpcode := branch opcode caseOf: {
		[JumpOverflow]		-> [BrSignedLessRR].
		[JumpNoOverflow]	-> [BrSignedGreaterEqualRR].
	} otherwise: [self unreachable. 0].
	branch rewriteOpcode: newBranchOpcode with: Overflow with: ZR.
	^branch