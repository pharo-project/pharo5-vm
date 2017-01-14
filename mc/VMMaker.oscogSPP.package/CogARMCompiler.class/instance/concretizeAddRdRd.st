generate machine code - concretize
concretizeAddRdRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"Add FP regRHS to FP regLHS and stick result in FP regLHS"
	| regLHS regRHS |
	regRHS := operands at: 0.
	regLHS := operands at: 1.
	machineCode at: 0 put:(self faddd: regLHS with: regRHS).
	^machineCodeSize := 4
	