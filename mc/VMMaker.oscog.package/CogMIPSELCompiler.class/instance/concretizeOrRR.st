generate machine code - concretize
concretizeOrRR
	| destReg leftReg rightReg |
	rightReg := operands at: 0.
	destReg := leftReg := operands at: 1.
	self machineCodeAt: 0 put: (self orR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4