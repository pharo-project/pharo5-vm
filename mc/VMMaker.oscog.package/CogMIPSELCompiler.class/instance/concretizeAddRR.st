generate machine code - concretize
concretizeAddRR
	| destReg leftReg rightReg |
	rightReg := self concreteRegister: (operands at: 0).
	destReg := leftReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self adduR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4