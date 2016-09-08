generate machine code - concretize
concretizeLogicalShiftLeftRR
	| destReg distReg |
	distReg := operands at: 0.
	destReg := operands at: 1.
	self machineCodeAt: 0 put: (self sllvR: destReg R: destReg R: distReg).
	^machineCodeSize := 4