generate machine code - concretize
concretizeSubRR
	| leftReg rightReg |
	rightReg := self concreteRegister: (operands at: 0).
	leftReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self subuR: leftReg R: leftReg R: rightReg).
	^machineCodeSize := 4