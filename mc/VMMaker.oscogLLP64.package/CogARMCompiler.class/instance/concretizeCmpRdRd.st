generate machine code - concretize
concretizeCmpRdRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"Compare FP regB with FP regA and leave the FP status reg ready to be transferred back to ARM with next instruction"
	| regB regA |
	regA := operands at:0.
	regB := operands at: 1.
	machineCode at: 0 put:(self fcmpFrom: regB to: regA).
	^machineCodeSize := 4
		
