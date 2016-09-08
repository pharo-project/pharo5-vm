generate machine code - concretize
concretizeMoveRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	"cond 000 1101 0 0000 dest 0000 0000 srcR"
	self machineCodeAt: 0 put: (self mov: destReg rn: srcReg).
	^machineCodeSize := 4