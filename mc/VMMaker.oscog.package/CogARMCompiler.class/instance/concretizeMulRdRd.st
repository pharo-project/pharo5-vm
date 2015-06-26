generate machine code - concretize
concretizeMulRdRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"FP multiply regLHS by regRHS and stick result in regLHS"
	| regLHS regRHS |
	regRHS := self concreteDPFPRegister: (operands at: 0).
	regLHS := self concreteDPFPRegister: (operands at: 1).
	machineCode at: 0 put:(self fmuld: regLHS with: regRHS).
	^machineCodeSize := 4
	