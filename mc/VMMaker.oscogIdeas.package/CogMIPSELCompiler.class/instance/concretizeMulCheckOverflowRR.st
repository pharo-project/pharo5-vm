generate machine code - concretize
concretizeMulCheckOverflowRR
	| destReg leftReg rightReg |
	rightReg := operands at: 0.
	destReg := leftReg := operands at: 1.

	"Overflow occured if the sign bit of the low part is different from the high part."
	self machineCodeAt: 0 put: (self multR: leftReg R: rightReg).
	self machineCodeAt: 4 put: (self mfloR: destReg).
	self machineCodeAt: 8 put: (self sraR: OverflowTemp1 R: destReg C: 31).
	self machineCodeAt: 12 put: (self mfhiR: OverflowTemp2).
	^machineCodeSize := 16