generate machine code - concretize
concretizeOrCwR
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: ZR C: (self low16BitsOf: value)).
	self machineCodeAt: 8 put: (self orR: reg R: reg R: AT).
	^machineCodeSize := 12