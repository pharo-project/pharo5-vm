generate machine code - concretize
concretizeAddRR
	| destReg leftReg rightReg |
	rightReg := operands at: 0.
	destReg := leftReg := operands at: 1.
	self machineCodeAt: 0 put: (self adduR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4