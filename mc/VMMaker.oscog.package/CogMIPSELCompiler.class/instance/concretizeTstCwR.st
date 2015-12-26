generate machine code - concretize
concretizeTstCwR
	| leftReg rightImm |
	rightImm := operands at: 0.
	leftReg := operands at: 1.
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: rightImm)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: rightImm)).
	self machineCodeAt: 8 put: (self andR: Cmp R: leftReg R: AT).
	^machineCodeSize := 12