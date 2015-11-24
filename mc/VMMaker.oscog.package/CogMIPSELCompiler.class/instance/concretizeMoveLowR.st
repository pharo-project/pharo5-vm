generate machine code - concretize
concretizeMoveLowR
	| destReg |
	destReg := self concreteRegister: (operands at: 0).
	self machineCodeAt: 0 put: (self mfloR: destReg).
	^machineCodeSize := 4