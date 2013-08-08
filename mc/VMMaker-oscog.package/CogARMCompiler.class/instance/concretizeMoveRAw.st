generate machine code - concretize
concretizeMoveRAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destAddr |
	srcReg := self concreteRegister: (operands at: 0).
	destAddr := operands at: 1.
	"load the address into R3"
	self at: 0 moveCw: destAddr intoR: RISCTempReg.
	machineCode 
		at: 15 put: 16rE5; "STR srcReg, [R3, +LSB(addr)]"
		at: 14 put: (16r80 bitOr: RISCTempReg);
		at: 13 put: (srcReg << 4).
	^machineCodeSize := 16