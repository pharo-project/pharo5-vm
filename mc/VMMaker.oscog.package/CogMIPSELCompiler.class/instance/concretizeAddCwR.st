generate machine code - concretize
concretizeAddCwR
	| val reg |
	val := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: val)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: val)).
	self machineCodeAt: 8 put: (self adduR: reg R: reg R: AT).
	^machineCodeSize := 12