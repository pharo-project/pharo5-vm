generate machine code
concretizeXorRsRs
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| regLHS regRHS |
	regRHS := self operands at: 0.
	regLHS := self operands at: 1.
	machineCode
		at: 0 put: 16r0F;
		at: 1 put: 16r57;
		at: 2 put: (self mod: ModReg RM: regRHS RO: regLHS).
	^machineCodeSize := 3