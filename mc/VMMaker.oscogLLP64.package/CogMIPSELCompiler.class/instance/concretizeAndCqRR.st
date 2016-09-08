generate machine code - concretize
concretizeAndCqRR
	| value srcReg dstReg |
	value := operands at: 0.
	srcReg := operands at: 1.
	dstReg := operands at: 2.
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: value)).
	self machineCodeAt: 8 put: (self andR: dstReg R: srcReg R: AT).
	^machineCodeSize := 12