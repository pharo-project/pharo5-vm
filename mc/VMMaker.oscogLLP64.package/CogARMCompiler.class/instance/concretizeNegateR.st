generate machine code - concretize
concretizeNegateR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg |
	reg := operands at: 0.
	"RSB destReg, srcReg, #0"
	self machineCodeAt: 0 put: (self type: 1 op: RsbOpcode set: 0 rn: reg rd: reg).
	^machineCodeSize := 4