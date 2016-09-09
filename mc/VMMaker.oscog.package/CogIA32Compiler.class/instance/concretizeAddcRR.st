generate machine code
concretizeAddcRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"Assemble the ADC instruction"
	| regLHS regRHS |
	regLHS := operands at: 0.
	regRHS := operands at: 1.
	machineCode
		at: 0 put: 16r13;
		at: 1 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 2