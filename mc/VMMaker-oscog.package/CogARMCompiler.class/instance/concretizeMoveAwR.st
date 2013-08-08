generate machine code - concretize
concretizeMoveAwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcAddr destReg |
	srcAddr := operands at: 0.
	destReg := self concreteRegister: (operands at: 1).
	"load the address into RISCTempReg"
	self at: 0 moveCw: srcAddr intoR: RISCTempReg.
	"Moving allows building an 8bit offset, so the lowest byte can be used in this instruction and we save 4 byte."
	machineCode
		at: 15 put: 16rE5; "LDR srcReg, [R3, +LSB(addr)]"
		at: 14 put: (16r90 bitOr: RISCTempReg);
		at: 13 put: (destReg << 4).
	^machineCodeSize := 16