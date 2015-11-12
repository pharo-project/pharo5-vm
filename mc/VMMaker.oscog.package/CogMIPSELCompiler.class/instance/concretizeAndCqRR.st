generate machine code - concretize
concretizeAndCqRR
	| value srcReg dstReg |
	value := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	dstReg := self concreteRegister: (operands at: 2).
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: ZR C: (self low16BitsOf: value)).
	self machineCodeAt: 8 put: (self andR: dstReg R: srcReg R: AT).
	^machineCodeSize := 12