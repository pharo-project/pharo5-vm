generate machine code - concretize
concretizeDataOperationCwR: opcode
	"Will get inlined into concretizeAt: switch."
	"Load the word into the RISCTempReg, then cmp R, RISCTempReg"
	<inline: true>
	| constant srcDestReg |
	constant := operands at: 0.
	srcDestReg := (self concreteRegister: (operands at: 1)).
	self at: 0 moveCw: constant intoR: RISCTempReg.
	self machineCodeAt: 16 
		put: ((self t: 0 o: opcode s: 1) bitOr: ((srcDestReg << 16 bitOr: srcDestReg <<12) bitOr: RISCTempReg)).
	^machineCodeSize := 20.