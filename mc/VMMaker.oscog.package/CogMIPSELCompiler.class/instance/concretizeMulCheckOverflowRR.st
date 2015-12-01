generate machine code - concretize
concretizeMulCheckOverflowRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1). "Also destReg."

	"Overflow occured if the sign bit of the low part is different from the high part."
	self machineCodeAt: 0 put: (self multR: leftReg R: rightReg).
	self machineCodeAt: 4 put: (self mfloR: rightReg).
	self machineCodeAt: 8 put: (self sraR: OverflowTemp1 R: rightReg C: 31).
	self machineCodeAt: 12 put: (self mfhiR: OverflowTemp2).
	"Overflow contains 0 on overflow, non-zero otherwise."
	self machineCodeAt: 16 put: (self subuR: Overflow R: OverflowTemp1 R: OverflowTemp2).
	^machineCodeSize := 20