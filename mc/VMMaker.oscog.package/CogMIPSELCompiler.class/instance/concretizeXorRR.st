generate machine code - concretize
concretizeXorRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self xorR: rightReg R: leftReg R: rightReg).
	^machineCodeSize := 4