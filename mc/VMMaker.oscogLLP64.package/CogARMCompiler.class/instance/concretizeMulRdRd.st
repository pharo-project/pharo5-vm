generate machine code - concretize
concretizeMulRdRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"FP multiply regLHS by regRHS and stick result in regLHS"
	| regLHS regRHS |
	regRHS := operands at: 0.
	regLHS := operands at: 1.
	machineCode at: 0 put:(self fmuld: regLHS with: regRHS).
	^machineCodeSize := 4
	