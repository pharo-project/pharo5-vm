generate machine code - concretize
concretizeSubRR
	| destReg leftReg rightReg |
	rightReg := operands at: 0.
	destReg := leftReg := operands at: 1.
	self machineCodeAt: 0 put: (self subuR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4