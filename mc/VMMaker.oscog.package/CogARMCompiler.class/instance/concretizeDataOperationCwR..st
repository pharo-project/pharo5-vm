generate machine code - concretize
concretizeDataOperationCwR: opcode
	"Will get inlined into concretizeAt: switch."
	"Load the word into the RISCTempReg, then cmp R, RISCTempReg"
	<inline: true>
	| constant srcDestReg instrOffset|
	constant := operands at: 0.
	srcDestReg := (self concreteRegister: (operands at: 1)).
	instrOffset := self at: 0 moveCw: constant intoR: RISCTempReg.
	self machineCodeAt: instrOffset 
		put: (self type: 0 op: opcode set: 1 rn: srcDestReg rd: srcDestReg shifterOperand: RISCTempReg).
	^machineCodeSize := instrOffset + 4