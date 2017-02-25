generate machine code
concretizeSubbRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"Assemble the SBB instruction"
	| regLHS regRHS |
	regLHS := operands at: 0.
	regRHS := operands at: 1.
	machineCode
		at: 0 put: 16r1B;
		at: 1 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 2