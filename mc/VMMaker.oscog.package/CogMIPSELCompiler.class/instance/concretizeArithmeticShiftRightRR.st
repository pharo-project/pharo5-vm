generate machine code - concretize
concretizeArithmeticShiftRightRR
	| destReg distReg |
	distReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self sravR: destReg R: destReg R: distReg).
	^machineCodeSize := 4