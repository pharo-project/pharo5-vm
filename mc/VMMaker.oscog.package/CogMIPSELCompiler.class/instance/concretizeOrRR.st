generate machine code - concretize
concretizeOrRR
	| destReg leftReg rightReg |
	rightReg := self concreteRegister: (operands at: 0).
	destReg := leftReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self orR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4