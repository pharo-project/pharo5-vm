generate machine code - concretize
concretizeMoveXbrRR
	"Will get inlined into concretizeAt: switch."
	
	<inline: true>
	| index base dest |
	index := operands at: 0. "index is number of *bytes*"
	base := operands at: 1.
	dest := operands at: 2.
	"LDRB	dest, [base, +index, LSL #0]"
	"cond 011 1100 1 base dest 00000 00 0 inde"
	self machineCodeAt: 0 put: (self ldrb: dest rn: base rm: index).
	^machineCodeSize := 4