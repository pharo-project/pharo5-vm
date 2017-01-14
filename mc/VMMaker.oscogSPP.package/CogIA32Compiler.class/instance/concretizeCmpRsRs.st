generate machine code
concretizeCmpRsRs
	"Will get inlined into concretizeAt: switch.
	 We use UCOMISS (see p 4-260 [2])"
	<inline: true>
	| regLHS regRHS |
	"CmpRR RHS LHS computes LHS - RHS, i.e. apparently reversed.  You have to think subtract."
	regRHS := operands at: 0.
	regLHS := operands at: 1.
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16r2E;
		at: 2 put: (self mod: ModReg RM: regRHS RO: regLHS).
	^machineCodeSize := 3