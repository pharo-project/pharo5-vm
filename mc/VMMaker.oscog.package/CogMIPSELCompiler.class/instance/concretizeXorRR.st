generate machine code - concretize
concretizeXorRR
	| destReg leftReg rightReg |
	rightReg := operands at: 0.
	destReg := leftReg := operands at: 1.
	self machineCodeAt: 0 put: (self xorR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4