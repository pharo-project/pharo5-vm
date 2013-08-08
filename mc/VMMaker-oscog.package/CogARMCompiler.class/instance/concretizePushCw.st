generate machine code - concretize
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| word |
	word := operands at: 0.
	self at: 0 moveCw: word intoR: RISCTempReg.
	self machineCodeAt: 16 put: (self t: 2 o: 9 s: 0 rn: SP rd: RISCTempReg shifterOperand: 4).
	^machineCodeSize := 20