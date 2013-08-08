generate machine code - concretize
concretizeDataOperationRR: opcode
	"Will get inlined into concretizeAt: switch."
	"Load the word into the RISCTempReg, then cmp R, RISCTempReg"
	<inline: true>
	| destReg srcReg |
	srcReg := self concreteRegister: (operands at: 0).
	destReg := (self concreteRegister: (operands at: 1)).
	self machineCodeAt: 0 
		put: (self t: 0 o: opcode s: 1 rn: destReg rd: destReg shifterOperand: srcReg).
	^machineCodeSize := 4.