generate machine code - concretize
concretizeAddRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self adduR: rightReg R: leftReg R: rightReg).
	^machineCodeSize := 4