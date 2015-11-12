generate machine code - concretize
concretizeTstCwR
	| val reg |
	val := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: val)).
	self machineCodeAt: 4 put: (self oriR: AT R: ZR C: (self low16BitsOf: val)).
	self machineCodeAt: 8 put: (self andR: Cmp R: reg R: AT).
	^machineCodeSize := 12